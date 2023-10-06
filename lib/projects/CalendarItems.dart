import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarItemsFile extends StatelessWidget {
  const CalendarItemsFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController _controller = CalendarController();
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            title: Text('Calendar View'),
            actions: [
              MenuItemButton(
                  child: IconButton(onPressed: () async {
                    DateTime? datePickler= await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1947),
                        lastDate: DateTime(2050)
                    );
                  },
                  icon: Icon(Icons.calendar_month,color: Colors.white,))),
            ],
          ),
          body: SafeArea(
            child: SfCalendar(
              view: CalendarView.day,
              allowedViews: [
                CalendarView.day,
                CalendarView.week,
                CalendarView.month,
                CalendarView.timelineDay,
                CalendarView.workWeek
              ],
            ),
          ),
        )
    );
  }
}
