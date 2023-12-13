const http = require('http'),
      os = require('os');


var handler = function(request, response) {
  response.end("Sample application response");
};

var www = http.createServer(handler);
www.listen(8080);
