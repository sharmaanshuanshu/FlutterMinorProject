import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    connectToServer();
    super.initState();
  }

  void connectToServer() {
    socket = IO.io('http://192.168.1.31:5000',{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket?.connect();
print('we are here.....................');
    socket?.on('message', (data) {
      print('connect..........................');
      setState(() {
        messages.add(data);
      });
    });

    socket?.on('disconnect', (data) {
      print('Disconnect..........................');
    });

  }
  void sendMessage() {
    String message = messageController.text.trim();
    print(message);
    if (message.isNotEmpty) {
      socket?.emit('message', message);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Socket.IO Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }


}