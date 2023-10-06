import 'package:flutter/material.dart';

class ThemeChange extends StatefulWidget {
  bool check ;
  ThemeChange(this.check);

  @override
  State<StatefulWidget> createState() => _ThemeChnageState();
}

class _ThemeChnageState extends State<ThemeChange> {
  late bool _switchValue ;

  @override
  Widget build(BuildContext context) {
    _switchValue = widget.check;
    return Scaffold(
      body:  Switch(value: _switchValue,
        activeColor: Colors.white,
        inactiveTrackColor: Colors.red,
        activeTrackColor: Colors.green,
        onChanged: (newValue) {
          setState(() {
            _switchValue = newValue;
          });

        },),
    );
  }
}
