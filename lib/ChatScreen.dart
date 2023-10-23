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
  bool connectionCheck = false;
  var connect = 'Connect';
  var disConnect = 'Disconnect';

  @override
  void initState() {
    connectToServer();
    super.initState();
  }

  @override
  // void dispose() {
  //   super.dispose();
  //   socket?.disconnected;
  // }

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

    socket?.onConnect((_) {
      print("Yes Connected ");
      setState(() {
        connectionCheck = true;
      });
    } );

    socket?.on('disconnect', (data) {
      print('Disconnect..........................');
      setState(() {
        connectionCheck = false;
      });
    });

  }
  void sendMessage() {
    String message = messageController.text.trim();
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
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (messages.length > 0 && connectionCheck == true)? Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: ListTile(
                          title: Text(messages[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                               messages.removeAt(index);
                               setState(() {
                                 messages;
                               });
                            },
                          ),
                        ),
                      );
                    },
                  ),
              ) :  (messages.length==0 && connectionCheck == true) ? Text(connect,style: TextStyle(fontSize: 25 , color: Colors.green , fontWeight: FontWeight.bold)) :Text(disConnect,style: TextStyle(fontSize: 25 , color: Colors.red , fontWeight: FontWeight.bold)),
              Column(
                children: [
                  // Container(margin: EdgeInsets.only(top: 300), child: connectionCheck ?  Text('Connected',style: TextStyle(fontSize: 25 , color: Colors.green , fontWeight: FontWeight.bold)) :Text('Disconnected',style: TextStyle(fontSize: 25 , color: Colors.red , fontWeight: FontWeight.bold)) ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            controller: messageController,
                            onChanged: _onChanges,
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

            ],
          ),
        ),
      )
    );
  }

  _onChanges( String value){
    if(value.length > 0 && connectionCheck == true){
    setState(() {
      connect = '';
    });
    }
    if(value.length == 0 && messages.length == 0){
      setState(() {
        connect = 'Connect';
      });
    }

  }

  removeData(index) {
    messages.removeAt(index);
  }
  Future<void> refresh() async {

  }
}