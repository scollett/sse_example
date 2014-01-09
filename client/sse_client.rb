require 'sinatra'

set :port => '4567'

get '/' do
  '<html>' +
    '<head><script type="text/javascript" src="javascript/sse.js"></script></head>' +
    '<body>' +
      '<div id="intro"">Hello World!<br /><br />Calling out to the SSE test.</div>' +
      '<div id="responses"></div>' +
    '</body>' +
  '</html>'
end