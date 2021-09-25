import 'package:flutter/material.dart';
import 'package:weather/pages/calender.dart';
import 'package:weather/pages/home.dart';

void main() {
  runApp(MaterialApp(routes: {
    "/":(context)=>Home(),
    "/calender":(context)=>Calender()
  }));
}




