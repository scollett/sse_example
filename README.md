-----------------------------------------------------------------------------------------------------------
This is a super simple Ruby based Server Side Events (SSE) example application.
-----------------------------------------------------------------------------------------------------------

The client and server will run on your localhost under different port (server => 3000, client => 4567). 

To install, you will need to install the sinatra gem:
  > gem install 'sinatra'
	
And then startup the application:

  > ruby server/sse_server.rb
	  ruby client/sse_client.rb
	
Then navigate to the client's page in your browser:	

  > http://localhost:4567
	
The underlying javascript on the client page will create an EventSource object and register it with the sse_server as a subscriber.

Then call the message endpoint on the sse server to post a new message.
  In your browser (in a separate tab): 
	  
		> http://localhost:3000/sse/message?message=This%20Is%20A%20Test
	
	Or via curl: 
	  
		> curl 'http://localhost:3000/sse/message?message=This%20Is%20A%20Test'
		
The client in your first browser window, http://localhost:4567, should now display a timestamp and 'This Is A Test'
		