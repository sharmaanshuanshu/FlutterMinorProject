import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proofhubmobileapplication/projects/CalendarItems.dart';
import 'package:proofhubmobileapplication/projects/MultipleImagesUpload.dart';
import 'package:proofhubmobileapplication/projects/UploadGifFile.dart';
import 'package:proofhubmobileapplication/projects/ListViewLoading.dart';
import 'package:http/http.dart' as http;
import '../tasks/TaskGrid.dart';
import 'GridItems.dart';

class ProjectSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  List<dynamic> title = [];
  List<dynamic> subTitle = [];
  List<dynamic> images = [];
  late int compDatalength;
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {
    var prjocetColor = [
      Colors.green,
      Colors.blue,
      Colors.amber,
      Colors.purple,
      Colors.greenAccent,
      Colors.red
    ];
    var projectTitle = [
      InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TasksFormField()));
          },
          child: Container(child: Text('Tasks'.toUpperCase()))),
      InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CalendarItemsFile()));
          },
          child: Container(child: Text('Calender'.toUpperCase()))),
      ElevatedButton(
          // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          child: Text('Grid'.toUpperCase(), style: TextStyle(fontSize: 20)),
          onPressed: () async {
            var response = await http.get(
                Uri.parse('https://within.proofhub.com/api/v4/people'),
                headers: {
                  'Content-Type': 'application/json',
                  'X-API-KEY': '7bf004c161c903c98082a5b270d48e924912a99a'
                });
            var body = response.body;
            var compData = jsonDecode(body);
            compDatalength = compData.length;
            for (int i = 0; i < compData.length; i++) {
              title.add(compData[i]['first_name']);
              subTitle.add(compData[i]['email']);
              images.add(compData[i]['image_url']);
            }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Griditems(
                          title: title,
                          subTitle: subTitle,
                          images: images,
                          compDataLength: compDatalength,
                        )));
          },
        ),
      ElevatedButton(
           child: Text('List View Loading'.toUpperCase()),
        onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
        },
       ),
      InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MultiImagesUpload()));
          },
          child: Container(child: Text('Files'.toUpperCase()))),
      InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UploadGifFile()));
          },
          child: ElevatedButton(
              child: Text('GIF'.toUpperCase(), style: TextStyle(fontSize: 20)),
            onPressed: (){
                final response = http.get(Uri.parse('https://within.proofhub.com/link/gifs?q=All'),
                headers: {
                      'X-API-KEY': '7bf004c161c903c98082a5b270d48e924912a99a' });
               print(response);
            },
          )
      ),
    ];
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: 400,
              width: 300,
              color: Colors.white70,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: prjocetColor[index],
                    ),
                    title: projectTitle[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 20, thickness: 2);
                },
                itemCount: projectTitle.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
