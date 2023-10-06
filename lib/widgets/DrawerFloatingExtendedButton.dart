import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DrawerFloatingExtendedButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? callBack;

  DrawerFloatingExtendedButton(
      {required this.btnName,
      this.icon,
      this.bgColor = Colors.blue,
      this.textStyle,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          callBack!();
        },
        label: Text(btnName),
        icon: icon,
        heroTag: UniqueKey()
    );
  }
}
class FilesBar extends StatelessWidget {
  String? file_bar_title;
  List<File>? pdfFiles;


  FilesBar(this.file_bar_title, this.pdfFiles, {super.key});

  @override
  Widget build(BuildContext context) {
    print('pdfFiles ${pdfFiles}');
  return Scaffold(
    appBar: AppBar(
      title: Text(file_bar_title!),
    ),
    body: Container(
        child: file_bar_title == 'pdf'.toUpperCase()
            ? SfPdfViewer.file(pdfFiles as File)
            : Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(
                      pdfFiles as File),
                  fit: BoxFit.values[6])),
        )),
  );
  }

}
