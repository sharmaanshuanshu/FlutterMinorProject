import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Griditems extends StatefulWidget {
  List<dynamic> title = [];
  List<dynamic> subTitle = [];
  List<dynamic> images = [];
  int compDataLength;

  Griditems(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.images,
      required this.compDataLength})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridItemsState();
}

class _GridItemsState extends State<Griditems> {

  List<dynamic> _title = [];
  List<dynamic> _subTitle = [];
  List<dynamic> _images = [];
  late int _compDataLength;

  @override
  Widget build(BuildContext context) {
    _title = widget.title;
    _subTitle = widget.subTitle;
    _images = widget.images;
    _compDataLength = widget.compDataLength;
    print('_compDataLength ${_compDataLength}');

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Grid Items'),
        ),
        body: Column(
          children: [
            Expanded(
              child: _title.length == 0
                  ? Center(child: CircularProgressIndicator(color: Colors.blue))
                  : RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                        itemCount: _compDataLength,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage('${_images[index]}'),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text('${_title[index]}'),
                                subtitle: Text('${_subTitle[index]}'),
                                trailing: FaIcon(FontAwesomeIcons.person),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ));
  }

  Future refresh() async {
    setState(() {
      _compDataLength;
    });
  }

  void _scrollListeners() {}
}
