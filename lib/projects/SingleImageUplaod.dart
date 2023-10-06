import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SingleImageUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleImageUploadState();
}

class _SingleImageUploadState extends State<SingleImageUpload> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capturing Image'),
      ),
      body: Column(
        children: [
          if (imageFile != null)
            Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: FileImage(imageFile!), fit: BoxFit.cover)),
            )
          else
            Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Image should appear here'),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    getImages(source: ImageSource.camera);
                  },
                  child: Text('Camera')),
              ElevatedButton(
                  onPressed: () {
                    getImages(source: ImageSource.gallery);
                  },
                  child: Text('Gallery'))
            ],
          )
        ],
      ),
    );
  }

  void getImages({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      setState(() {
        imageFile = (File(file!.path));
      });
    }
  }
}
