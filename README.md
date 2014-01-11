-----------------------------------------------------------------------------------------------------------
This is a super simple Ruby based Server Side Events (SSE) example application.
-----------------------------------------------------------------------------------------------------------

The client and server are distributed in one application. The client is distributed by the Sinatra application via html/js and is run in the web browser (client-side) while the server streams from the application (server-side). 

To install, you will need to install the sinatra gem:
```
gem install 'sinatra'
```
	
And then startup the application:
```
ruby sse_demo.rb
```
	
Then navigate to the client's page in your browser:	
```
http://localhost:3000
```

The underlying javascript on the client page will create an EventSource object and register it with the sse_server as a subscriber.

Then call the message endpoint on the sse server to post a new message in a separate browser tab: 
```
http://localhost:3000/stream/message?message=Hello%20World!
```
		
The client in your first browser window, http://localhost:3000, should now display a timestamp and your message.
		