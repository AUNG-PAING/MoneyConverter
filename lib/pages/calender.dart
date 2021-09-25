import 'package:flutter/material.dart';
import 'package:calendar_agenda/calendar_agenda.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          
            child:CalendarAgenda(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 1830 )),
//             lastDate: DateTime.now().add(Duration(days: 4)),
          lastDate: DateTime.now(),
          onDateSelected: (date) {
            print(date);
          },
        )),
      ),
    );
  }
}
