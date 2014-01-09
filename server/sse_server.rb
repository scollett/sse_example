require 'sinatra'

set port: '3000'
set :bind, '0.0.0.0'
set server: 'thin'

connections = []  
  
# -------------------------------------------------------------------------------
# Sets up the caller as a subscriber for Server Side Events
# -------------------------------------------------------------------------------
get '/sse/subscribe' do
  stream(:keep_open) do |out|      
    connections << out
    out.callback { connections.delete(out) }
      
    out.errback do
      logger.warn 'we just lost a connection!'
      connections.delete(out)
    end
  end
end
  

# -------------------------------------------------------------------------------
# Receives an update message and send it out to the Server Side Event Subscriber  
# -------------------------------------------------------------------------------
get '/sse/message' do
  connections.each do |out|      
    # The text/event-stream content type requires a 'data:' element and '\n\n' to denote the end of the response. 
    # If you have multiple lines to send back, they should be separated with a '\n' and the final line should have the '\n\n'
    out << "data: #{Time.now} -> #{params[:message]}" << "\n\n"
  end
    
  "message_received (#{params[:message]})"
end

# -------------------------------------------------------------------------------
# Forwards to the message end point with an example 'Hello World!'  
# -------------------------------------------------------------------------------
get '/' do
  redirect '/sse/message?message=Hello%20World!'
end

# -------------------------------------------------------------------------------
# Default HTTP Headers for all responses 
# -------------------------------------------------------------------------------
before do
  response['Access-Control-Allow-Origin'] = env['HTTP_ORIGIN']
  response['Cache-Control'] = 'no-cache'
  content_type 'text/event-stream'
end