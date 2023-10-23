import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:proofhubmobileapplication/widgets/FilesAppBar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MultiImagesUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultiImagesUploadState();
}

class _MultiImagesUploadState extends State<MultiImagesUpload> {
  List<File> multiImages = [];
  var extensions;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < multiImages.length; i++) {
      var path = multiImages[i].path;
      extensions = path.split(".").last;
    }
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: multiImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>

                                  // CarouselSlider(
                                  //
                                  //   items: [
                                  //     Container(
                                  //       decoration: BoxDecoration(
                                  //           image: DecorationImage(
                                  //               image: FileImage(multiImages[index]),
                                  //               fit: BoxFit.fill
                                  //           )
                                  //       ),
                                  //     ),
                                  //   ], options: CarouselOptions(),
                                  // ),

                                  //

                                  // CarouselSlider(
                                  //   items:[
                                  //     Container(
                                  //       decoration: BoxDecoration(
                                  //           image: DecorationImage(
                                  //             image: FileImage(multiImages[index]),
                                  //           )
                                  //       ),
                                  //     ),
                                  //   ],
                                  //   options: CarouselOptions(
                                  //     height: 300,
                                  //   ),
                                  //
                                  //   )

                                  PageView.builder(
                                      itemCount: multiImages.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CustomAppBar(extensions),
                                            Expanded(
                                              child: Container(
                                                child: extensions == 'pdf'
                                                    ? SfPdfViewer.file(
                                                        multiImages[index])
                                                    :   Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: FileImage(
                                                              multiImages[
                                                                  index]),
                                                        )),
                                                      ),
                                              ),
                                            )
                                          ],
                                        );
                                      })

                          ));
                    },
                    child: extensions == 'pdf'
                        ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                                child: Icon(
                              Icons.picture_as_pdf_outlined,
                              size: 30,
                              color: Colors.red,
                            )),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(multiImages[index]),
                                    fit: BoxFit.fill)),
                          ),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: ElevatedButton(
                onPressed: () {
                  getMultiSelectImages();
                },
                child: Text('SELECT')),
          )
        ],
      ),
    ));
  }

  Future<void> getMultiSelectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Allow the selection of multiple files
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'png',
        'jpeg',
        'gif'
      ], // Specify the allowed file types
    );

    if (result != null) {
      setState(() {
        multiImages = result.paths.map((path) => File(path!)).toList();
      });
    }
  }
}
//   void getMultiSelectImages({required ImageSource source}) async {
//     List<XFile> multipleFiles = await ImagePicker().pickMultiImage();
//     setState(() {
//       multiImages = multipleFiles.map((e) => File(e.path)).toList();
//     });
//   }
// }
