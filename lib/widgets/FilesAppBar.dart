import 'dart:io';

import 'package:flutter/material.dart';

import '../projects/DownloadFile.dart';
class CustomAppBar extends StatelessWidget {
    String? barTitle;

    CustomAppBar(this.barTitle);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the shadow
        title: Text(barTitle!),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.download,color: Colors.black),
                      onPressed: () {
                          print('Fileeeeeeeeeeeeeeeeee');
                          downloadFile();
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //           child: Text('OK'),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );

                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Downlaod")
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.help,color: Colors.black),
                      onPressed: () {  }),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Help")
                  ],
                ),
              ),
            ],
            offset: Offset(0, 66),
            color: Colors.white,
            elevation: 1,
          ),
        ],
      ),
    );
  }
}