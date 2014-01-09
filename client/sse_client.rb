require 'sinatra'
set :port => '4567'
set :bind, '0.0.0.0'

get '/' do
  '<html>' +
    '<head><script type="text/javascript" src="javascript/sse.js"></script></head>' +
    '<body>' +
      '<div id="demo"><h3>Server Side Events Demo</h3>Server Location: <input type="text" size="60" value="http://' + env['SERVER_NAME'] + ':3000" id="sse_host"> <br /> <br /> <a href="javascript:startConnection();">Run Demo</a><br /><br />' +
      '<div id="intro"></div>' +
      '<div id="responses"></div>' +
    '</body>' +
  '</html>'
end