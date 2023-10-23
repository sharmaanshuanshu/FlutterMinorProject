import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiUrl = "https://jsonplaceholder.typicode.com/albums/1/photos";
  int pageNo = 1;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  List albums = [];
  bool _switchValue = true;

  void _fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List albumList = [];

        pageNo =
            (pageNo > 100) ? 1 : pageNo++; // resetting and incrementing page
        apiUrl = "https://jsonplaceholder.typicode.com/albums/$pageNo/photos";
        var resultBody = jsonDecode(response.body);
        for (int i = 0; i < resultBody.length; i++) {
          albums.add(resultBody[i]);
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
      }
    }
  }

  @override
  void initState() {
    this._fetchData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  Widget _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: albums.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == albums.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            )),
          );
        } else {

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(albums[index]['thumbnailUrl']),
                ),
                title: Text((albums[index]['title'])),
                onTap: () {
                  print(albums[index]);
                },
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _switchValue ? Colors.white:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Pagination"),
        actions: [
          Switch(value: _switchValue,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.red,
            activeTrackColor: Colors.green,
            onChanged: (newValue) {
              setState(() {
                _switchValue = newValue;
              });

            },)
        ],
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
