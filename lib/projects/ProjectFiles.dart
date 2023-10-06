import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proofhubmobileapplication/projects/FullImages.dart';

class ProjectFiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<ProjectFiles> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Multiple Image Picker Flutter"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  //open button ----------------
                  ElevatedButton(
                      onPressed: () {
                        openImages();
                      },
                      child: Text("Open Images")),
                  Divider(),
                  Text("Picked Files:"),
                  Divider(),
                  imagefiles != null
                      ? Wrap(
                          children: imagefiles!.map((imageone) {
                            return Container(
                                child: Card(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 200,
                                  width: 100,
                                  child: Image.file(File(imageone.path)),
                                ),
                              ),
                            ));
                          }).toList(),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ));
  }
}
