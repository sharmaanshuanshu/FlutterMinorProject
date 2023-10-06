import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proofhubmobileapplication/projects/ProjectFiles.dart';
import 'package:proofhubmobileapplication/widgets/DrawerFloatingExtendedButton.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/AccountUrl.dart';
import '../projects/AllProjects.dart';

class PanelWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {

  final _lightTheme = ThemeData(
      brightness: Brightness.light,
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.black
      )
    )
  );

  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
          bodyText2: TextStyle(
              color: Colors.white
          )
      )
  );

  bool _switchValue =true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: _switchValue ? _lightTheme : darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _switchValue ? Colors.blue : Colors.blue ,
          actions: [
            Switch(
              activeColor: Colors.white,
                value: _switchValue,
                onChanged: (newValue){
                  setState(() {
                    _switchValue = newValue;
                  });
            })
          ],
        ),
        body:
           Container(
             child:  Center(
               child: SlidingUpPanel(
                 color: _switchValue ? Colors.white : Colors.black,
                 maxHeight: size.height * 0.5,
                 minHeight: size.height * 0.1,
                 panelBuilder: (controller) {
                   return ListView(
                     children: [
                       Center(
                         child: Column(
                           children: [
                             Container(
                               margin: EdgeInsets.fromLTRB(0, 3, 20, 0),
                               height: 3,
                               width: 60,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: Colors.grey),
                             ),
                           ],
                         ),
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                                 margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                 child: Column(
                                   children: [
                                     Icon(Icons.home),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text('Me'.toUpperCase(),
                                           style: TextStyle(
                                             fontSize: 10,
                                           )),
                                     )
                                   ],
                                 )),
                             GestureDetector(
                               onTap: () {
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => AllProjects()));
                               },
                               child: Container(
                                   margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                   child: Column(
                                     children: [
                                       Icon(Icons.folder),
                                       Padding(
                                         padding: const EdgeInsets.all(8),
                                         child: Text('Projects'.toUpperCase(),
                                             style: TextStyle(
                                               fontSize: 10,
                                             )),
                                       )
                                     ],
                                   )),
                             ),
                             Container(
                                 margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                 child: Column(
                                   children: [
                                     FaIcon(FontAwesomeIcons.house),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text('Activities'.toUpperCase(),
                                           style: TextStyle(
                                             fontSize: 10,
                                           )),
                                     )
                                   ],
                                 )),
                             Container(
                                 margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                 child: Column(
                                   children: [
                                     Icon(Icons.chat),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text('Chat'.toUpperCase(),
                                           style: TextStyle(fontSize: 10)),
                                     )
                                   ],
                                 )),
                             Container(
                                 margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                 child: Column(
                                   children: [
                                     FaIcon(FontAwesomeIcons.globe),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text('Everything'.toUpperCase(),
                                           style: TextStyle(
                                             fontSize: 10,
                                           )),
                                     )
                                   ],
                                 )),
                           ],
                         ),
                       ),
                       Center(
                         child: Column(
                           children: [
                             Container(
                               margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                               child:
                               Text('Quick Add', style: TextStyle(fontSize: 18)),
                             )
                           ],
                         ),
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                                 width: 150,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.redAccent.withOpacity(0),
                                     ),
                                   ],
                                 ),
                                 margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                 child: DrawerFloatingExtendedButton(
                                   btnName: 'Topic',
                                   icon: Icon(Icons.save),
                                   callBack: () {},
                                 )),
                             Container(
                                 width: 150,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.redAccent.withOpacity(0),
                                     ),
                                   ],
                                 ),
                                 margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                 child: DrawerFloatingExtendedButton(
                                   btnName: 'Tasks',
                                   icon: Icon(Icons.book),
                                   callBack: () {},
                                 )),
                           ],
                         ),
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                                 width: 150,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.redAccent.withOpacity(0),
                                     ),
                                   ],
                                 ),
                                 margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                 child: DrawerFloatingExtendedButton(
                                   btnName: 'Event',
                                   icon: Icon(Icons.calendar_month),
                                   callBack: () {},
                                 )),
                             Container(
                                 width: 150,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.redAccent.withOpacity(0),
                                     ),
                                   ],
                                 ),
                                 margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                 child: DrawerFloatingExtendedButton(
                                   btnName: 'Note',
                                   icon: Icon(Icons.note),
                                   callBack: () {},
                                 )),
                           ],
                         ),
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                                 width: 150,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.redAccent.withOpacity(0),
                                     ),
                                   ],
                                 ),
                                 margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                 child: DrawerFloatingExtendedButton(
                                   btnName: 'Time',
                                   icon: Icon(Icons.lock_clock),
                                   callBack: () {},
                                 )),
                             Container(
                                 width: 150,
                                 decoration: BoxDecoration(
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.redAccent.withOpacity(0),
                                     ),
                                   ],
                                 ),
                                 margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                 child: DrawerFloatingExtendedButton(
                                   btnName: 'Announcment',
                                   icon: Icon(Icons.home_repair_service_rounded),
                                   callBack: () {},
                                 )),
                           ],
                         ),
                       )
                     ],
                   );
                 },
                 // borderRadius:BorderRadius.vertical(top: Radius.circular(25)),
               ),
             ),
        ),

      ),
    );
  }
}
