import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';

class FullImages extends StatelessWidget {
  List<XFile>? imagefiles;

  FullImages(this.imagefiles);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: imagefiles != null ? Container() : Container(),
    );
  }
}
