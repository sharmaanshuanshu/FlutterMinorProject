import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadGifFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadGifFileState();
}

class _UploadGifFileState extends State<UploadGifFile> {
  List<File> multiGif = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gif File'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemCount: multiGif.length,
                    itemBuilder: (context, index) {
                      print(multiGif);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageView.builder(
                                      itemCount: multiGif.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: FileImage(multiGif[index]),
                                          )),
                                        );
                                      })));
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(multiGif[index]),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    UploadGif();
                  },
                  child: Text('Upload Gif')),
            )
          ],
        ),
      ),
    );
  }

  UploadGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      // Allow the selection of multiple files
      type: FileType.custom,
      allowedExtensions: ['gif'], // Specify the allowed file types
    );

    if (result != null) {
      setState(() {
        multiGif = result.paths.map((path) => File(path!)).toList();
      });
    }
  }
}
