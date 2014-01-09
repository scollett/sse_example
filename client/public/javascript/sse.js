
var source = null;

// If the browser allows EventSource, create one otherwise resort to JQuery Polling

function startConnection()
{
  var sse_path = "/sse/subscribe"
  var sse_location = document.getElementById("sse_host").value + sse_path

  if (!!window.EventSource) {
    var source = new EventSource(sse_location);
    document.getElementById("intro").innerHTML = "Connecting to SSE Server (" + sse_location + ")...<br /><br />";
    document.getElementById("responses").innerHTML = "Streaming Responses...<br />";
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
}



