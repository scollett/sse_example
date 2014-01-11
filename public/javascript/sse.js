
var source = null;

// If the browser allows EventSource, create one otherwise resort to JQuery Polling

function startConnection()
{
  var sse_path = "/stream/subscribe"

  if (!!window.EventSource) {
    var source = new EventSource(sse_path);
    document.getElementById("intro").innerHTML = "Connecting to SSE Server...<br /><br />";
    document.getElementById("responses").innerHTML = "Streaming Responses...<br />";
    source.onmessage = function(event) {
      console.log(event.data);
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



