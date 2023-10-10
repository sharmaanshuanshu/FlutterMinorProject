const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const socketIo = require('socket.io');

const io = socketIo(server);

const PORT = 5000 || process.env.PORT;

server.listen(PORT, () => {
  console.log(`http:${PORT}`);
});

// Define Socket.io events
io.on('connection', (socket) => {
  console.log('A user connected');

  socket.on('message', (data) => {
    console.log('Received message:', data);
    // Broadcast the message to all connected clients
    io.emit('message', data);
  });

  socket.on('disconnect', () => {
    console.log('A user disconnected');
  });
});
