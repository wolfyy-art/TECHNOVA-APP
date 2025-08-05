const http = require('http');
const port = 80;

const requestHandler = (request, response) => {
  response.end('Hello, World from TechNova!');
};

const server = http.createServer(requestHandler);
server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
