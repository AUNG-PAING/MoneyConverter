import 'package:flutter/material.dart';
import 'package:weather/api.dart';
import 'package:weather/global.dart';
import 'package:weather/model/symbols.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:weather/pages/calender.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var mySelection;
  var mySelection2;
  var mount=TextEditingController();
  var chooseDate;
  var groupValue;
  var date=Global.date;
  int error=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Container(
        padding:EdgeInsets.all(30),
        child:Column(children: [
          Expanded(
            child: Container(
//              color: Colors.deepOrangeAccent,
              child: FutureBuilder(
                  future: Api.getSymbolsName(),
                  builder:(context,snapShot)=>snapShot.hasData ?
                  RefreshIndicator(child:CustomScrollView(slivers: [SliverToBoxAdapter(child: Container(

                    child: Column(
                        children: [
                          Container(height: 50,child: Text(error ==0 ? "Please Select & Type" :"Check Your Input Data",style: TextStyle(color:error ==0 ?Colors.black:Colors.redAccent ,fontSize: 20), ),),
                          SizedBox(height: 30,),
                          Container(
                              child: DropdownButton(
                                  hint: Text("From             Select Here"),
                                  icon: Icon(Icons.arrow_drop_down,size: 40,),
                                  value: mySelection,
                                  isExpanded: true,
                                  onChanged: (value){
                                    setState(() {
                                      print(value.toString());
                                      mySelection= value;
                                      Global.results=null;

                                    });
                                  },
                                  items:Global.symbols.map((e){
                                    return DropdownMenuItem(
                                        value: e.shortSymbols,
                                        child:Text(e.shortSymbols +"  "+ e.countryName) );
                                  }).toList()
                              )

                          ),
                          SizedBox(height: 30,),
                          Container(
                            child: TextFormField(
                              controller: mount,
                              keyboardType: TextInputType.number,

                              decoration:InputDecoration(
                                  labelText:'Mount ?',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
                              ),),
                          ),
                          SizedBox(height: 30,),
                          Container(
                              child: DropdownButton(
                                  hint: Text("To                  Select Here"),
                                  icon: Icon(Icons.arrow_drop_down,size: 40,),
                                  value: mySelection2,
                                  isExpanded: true,
                                  onChanged: (value){
                                    setState(() {
                                      print(value.toString());
                                      mySelection2= value;
                                      Global.results=null;

                                    });
                                  },
                                  items:Global.symbols.map((e){
                                    return DropdownMenuItem(
                                        value: e.shortSymbols,
                                        child:Text(e.shortSymbols +"  "+ e.countryName) );
                                  }).toList()
                              )

                          ),
                          SizedBox(height: 30,),
                          Row(children: [
                            Row(
                              children: [Radio(
                                  value: 1, groupValue: groupValue, onChanged:(valuee){
                                groupValue=valuee;
                                chooseDate = null;
                                setState(() {

                                });
                              }),Container(
                                  width: 100,
                                  child: Text("Time of Now $date"))],
                            ),
                            Row(
                              children: [Radio(

                                  value: 2, groupValue:groupValue,
                                  onChanged:(value){
                                    groupValue=value;
                                    calender();
                                    setState(() {

                                    });
                                  }),Container(
                                  width: 100,
                                  child: chooseDate != null ? Text("Time of Other $chooseDate"):Text("Time of Other"))],
                            ),
                            SizedBox(width: 20,),
                            InkWell(
                                onTap: (){
                                  if(chooseDate != null){
                                    calender();
                                    setState(() {

                                    });
                                  }
                                  else {
                                    print("null");
                                    null;
                                  }
                                },
                                child: Icon(Icons.calendar_today,color: groupValue == 2 ? Colors.pinkAccent :Colors.blueGrey)),


                          ],),

                          SizedBox(height: 30,),
                          Container(
                            height: 50,
                            child: Center(child: Global.results==null ? Text("Please select to Convert"):Text(Global.results.result +"  "+ mySelection2)),),
                          InkWell(
                            onTap: ()async{
                              if(mySelection==null || mySelection2==null || mount.text.length == 0 || groupValue == null){
                                error=1;
                                setState(() {

                                });
                                return;
                              }
                              else{
                                await convertAlert(mySelection,mySelection2, mount.text);
                                error=0;
                                setState(() {

                                });
                              }

                            },
                            child: Container(
                                height: 40,width: 200,
                                child: Center(child: Text("Go",style: TextStyle(fontSize: 25,color: Colors.white),),),
                                // ignore: prefer_const_constructors
                                decoration:BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.all(Radius.circular(5)))),
                          ),

                        ] ),
                  ),)],), onRefresh:(){
                    return Future.value(false);
                  })
                      :
                  RefreshIndicator(child:Center(child: CircularProgressIndicator(),), onRefresh:()async{
                    Api.getSymbolsName();
                    setState(() {

                    });
                  })

              ),
            ),
          ),


        ],)
      ),
//        floatingActionButton: FloatingActionButton(onPressed: ()async{
//          await Api.getSymbolsName();
//          for (var element in Global.symbols) {
//            print(element.countryName);
//          }
//        },),
      ),
    );

}
  convertAlert(from, to, mount){
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder:(BuildContext context){
          return FutureBuilder(
            future: Api.convert(from, to, mount, chooseDate != null ? chooseDate : Global.date),
              builder:(context, snapShot)=>snapShot.hasData ?
                  RefreshIndicator(child:
                  AlertDialog(
                      title:
                      Text(Global.results.result +' '+ mySelection2),content: Container(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      Row(children: [Container(width: 70,child: Text("From"),),Text(Global.results.quary.amount +" "+ Global.results.quary.from)],),
                        Row(children: [Container(width: 70,child: Text("Rate"),),Text(Global.results.info.rate)],),
                        Row(children: [Container(width: 70,child: Text("Date"),),Text(Global.results.date)],),
                    ],),
                  ),
                    actions: [
                      FlatButton(
                          onPressed: (){
                            Navigator.pop(context);
                            setState(() {

                            });
                          }, child:Text("Ok",style: TextStyle(color: Colors.deepOrangeAccent),))
                    ],
                  ),

                      onRefresh:(){

                    setState(() {

                    });
                    return Future.value(false);

                  }):
              RefreshIndicator(child:AlertDialog(title: Container(
                height: 40,width: 40,
                  child: CircularProgressIndicator())), onRefresh:()async{
                await Api.convert(from, to, mount, chooseDate != null ? chooseDate : Global.date);
                setState(() {

                });
              })
          );
        });
  }

changeGroupValue(int val){
    groupValue=val;
}
calender(){
  Navigator.push(context,MaterialPageRoute(builder:(context)=>
      SafeArea(
        child: Scaffold(
            body: CalendarDatePicker(initialDate: DateTime.now(), firstDate:DateTime.now().subtract(Duration(days: 3660)), lastDate:DateTime.now(),
                onDateChanged:(a){
                  chooseDate=a.toString().substring(0,10);
                  print(chooseDate);
                  Navigator.pop(context);
                  return;
                })),
      )));
}
}
