import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proofhubmobileapplication/LocalNotifications.dart';
import 'package:proofhubmobileapplication/channel/AddChannel.dart';
import 'package:proofhubmobileapplication/channel/FlutterChannel.dart';
import 'package:proofhubmobileapplication/tasks/TaskAddEditForm.dart';
import 'package:proofhubmobileapplication/widgets/ThemeChange.dart';

import '../widgets/MultiFileUpload.dart';

class TasksFormField extends StatefulWidget {
  // List<dynamic> title = [];
  // String title;
  //
  // TasksFormField({
  //   Key? key,
  //   required this.title,
  // }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TasksFormFieldState();
}

class _TasksFormFieldState extends State<TasksFormField> {

  final _taskFormKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    LocalFlutterNotification().intilizeNotification();
  }

  List<dynamic> titleList = [];
  List<dynamic> sub_title = [];

  var _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();

  final title = TextEditingController();
  final _subTitle = TextEditingController();
  final _startDate = TextEditingController();
  final _DueDate = TextEditingController();
  // bool _switchValue = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FlutterChannel(),
      // backgroundColor: _switchValue ? Colors.white:Colors.black,
        appBar: AppBar(
          title: Text('Tasks'),
          actions: [
            Container(
                // child: ThemeChnage()
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                height: 30,
                width: 90,
                child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // Return your custom form window widget here.
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Form(
                                      key: _taskFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                'Title',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 0),
                                              child: TextFormField(
                                                controller: title,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                'Description:',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 0),
                                              child: TextFormField(
                                                controller: _subTitle,
                                                keyboardType: TextInputType
                                                    .multiline,
                                                maxLines: 4,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: Colors
                                                                .redAccent))),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(
                                            //       15.0),
                                            //   child: ElevatedButton(
                                            //       onPressed: () {
                                            //         MultiFileUpload filesPath = MultiFileUpload();
                                            //         filesPath.pickFiles();
                                            //       },
                                            //       child: Container(child: Text(
                                            //           'Upload File'))),
                                            // ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(15),
                                            //   child: TextFormField(
                                            //     controller: _startDate,
                                            //     decoration: InputDecoration(
                                            //         border: OutlineInputBorder(),
                                            //         hintText: 'StartDate',
                                            //         suffixIcon: IconButton(
                                            //           icon: Icon(
                                            //             Icons.calendar_month,
                                            //             color: Colors.black,
                                            //           ),
                                            //           onPressed: () {
                                            //             getStartDate();
                                            //           },
                                            //         )),
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding: const EdgeInsets.all(15),
                                            //   child: TextFormField(
                                            //     controller: _DueDate,
                                            //     decoration: InputDecoration(
                                            //         border: OutlineInputBorder(),
                                            //         hintText: 'DueDate',
                                            //         suffixIcon: IconButton(
                                            //           icon: Icon(
                                            //             Icons.calendar_month,
                                            //             color: Colors.black,
                                            //           ),
                                            //           onPressed: () {
                                            //             getDueDate();
                                            //           },
                                            //         )),
                                            //   ),
                                            // ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      8.0),
                                                  child: TextButton(
                                                    child: Text('ADD'),
                                                    onPressed: () {
                                                      setState(() {
                                                        titleList.add(title.text.toString());
                                                        sub_title.add(_subTitle.text.toString());
                                                      });
                                                      Navigator.pop(context);
                                                      _taskFormKey.currentState?.reset();
                                                    }
                                                      )
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.all(
                                                        8.0),
                                                    child: TextButton(
                                                        child: Text('CANCEL'),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          _taskFormKey.currentState?.reset();
                                                        }
                                                    )
                                                )
                                              ]
                                            )
                                          ],
                                        )
                                    )
                                  ],

                                ),
                              ),

                            );
                          });
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add'))),
            // Switch(value: _switchValue,
            //         inactiveTrackColor: Colors.white,
            //     onChanged: (newValue){
            //   setState(() {
            //     _switchValue = newValue;
            //   });
            // }),
            Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: titleList.length,
                itemBuilder: (context , index){
              return SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      titleList;
                    });
                  },
                  child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${titleList[index].toString().split(" ")[0][0]}'),
                      ),
                      title: Text('${titleList[index]}'),
                      subtitle: Text('${sub_title[index]}'),
                      trailing: IconButton(
                       icon: Icon(Icons.delete,color:Colors.red),

                        onPressed: () {
                          String notificationTitle = titleList[index];
                       String notificationSubTitle = sub_title[index];

                         setState(() {
                           titleList.removeAt(index);
                           titleList;
                           LocalFlutterNotification().sendNotification('User', 'Delete');

                         });

                        },

                      ),
                    ),
                ),
              );
            }),
          )
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                  onPressed: (){
                    // localFlutterNotification.scheduleNotification('AAA','BBB','CCCC');
                    // notificationService.scheduleNotification( 'title', 'body');
                    LocalFlutterNotification().zonedScheduleNotification();
                    // LocalFlutterNotification().scheduleNotiWithCron();
                  },
                  child: Text('Show Notificaion')),
            )
          ],
        ));
  }

  Future<DateTime?> getStartDate() async {
    DateTime? datePickler = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(1947),
        lastDate: DateTime(2050),
        context: context);
    _date = '${datePickler?.day}/${datePickler?.month}/${datePickler?.year}';
    setState(() {
      _startDate.text = _date;
    });
    return datePickler;
  }

  Future<DateTime?> getDueDate() async {
    DateTime? datePickler = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(1947),
        lastDate: DateTime(2050),
        context: context);
    _date = '${datePickler?.day}/${datePickler?.month}/${datePickler?.year}';
    setState(() {
      _DueDate.text = _date;
    });
    return datePickler;
  }
}
