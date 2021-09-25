import 'package:weather/model/convertModel.dart';
import 'package:weather/model/symbols.dart';
import 'package:intl/intl.dart';

//final dateFormatter = DateFormat('yyyy-MM-dd');
//final dateString = dateFormatter.format(DateTime.now());
//static var dateNow=dateString;

var today = DateTime.now();
var date = DateTime(today.year, today.month, today.day).toString().substring(0,10);


class Global{
  static List symbols=[];
  static var date = DateTime(today.year, today.month, today.day).toString().substring(0,10);
  static var results;



}