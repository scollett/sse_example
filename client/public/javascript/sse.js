var sse_host = "http://localhost:3000/sse/subscribe"

var source = null;

// If the browser allows EventSource, create one otherwise resort to JQuery Polling
if (!!window.EventSource) {
  var source = new EventSource(sse_host);
	
	source.onmessage = function(event) {
		document.getElementById("responses").innerHTML += event.data + "<br />";
	};
	
	source.onerror = function(error) {
		if(source.readyState != EventSource.CLOSED){
			document.getElementById("responses").innerHTML += "An Error occured!!<br />";
		}
	}
	
} else {
  // Result to xhr polling :(
		
}


