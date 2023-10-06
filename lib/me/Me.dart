import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PanelWidget.dart';
class Me extends StatefulWidget {
  // Password({ required this.email});
  @override
  State<StatefulWidget> createState() => _MeState();
}
class _MeState extends State<Me> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PanelWidget()
    );
  }
}
