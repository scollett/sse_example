require 'sinatra'

set port: '3000'
set :bind, '0.0.0.0'
set server: 'thin' # use thin, not webrick for compatibility

# ******** CLIENT CODE ******** 
# -------------------------------------------------------------------------------
# Serves the client code. JS embedded in HTML subscribes to the server stream
# -------------------------------------------------------------------------------
get '/' do
  erb :client
end


# ******** SERVER CODE ******** 
connections = []  

# -------------------------------------------------------------------------------
# Sets up the caller as a subscriber for Server Side Events
# -------------------------------------------------------------------------------
get '/stream/subscribe' do
  stream(:keep_open) do |out|
    connections << out
    puts connections.inspect
    out.callback { connections.delete(out) }
    
    # Heartbeat required. HTTP closes connections ~30 seconds.     
    EventMachine::PeriodicTimer.new(20) do 
      logger.info 'heartbeat!'
      out << "\0"
    end 
    
    # FIXME: Is callback/errback the same?
    out.errback do
      logger.warn 'we just lost a connection!'
      connections.delete(out)
    end
  end
end

# -------------------------------------------------------------------------------
# Receives an update message and send it out to the Server Side Event Subscriber  
# -------------------------------------------------------------------------------
get '/stream/message' do
  connections.each do |out|      
    # The text/event-stream content type requires a 'data:' element and '\n\n' to denote the end of the response. 
    # If you have multiple lines to send back, they should be separated with a '\n' and the final line should have the '\n\n'
    out << "data: #{Time.now} -> #{params[:message]}" << "\n\n"
  end
    
  "message_received (#{params[:message]})"
end

# -------------------------------------------------------------------------------
# Streaming HTTP Headers for all responses 
# -------------------------------------------------------------------------------
['/stream/*'].each do |path|
    before path do
      response['Access-Control-Allow-Origin'] = env['HTTP_ORIGIN']
      response['Cache-Control'] = 'no-cache'
      content_type 'text/event-stream'
    end
end
