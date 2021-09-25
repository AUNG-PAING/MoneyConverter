import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/global.dart';
import 'package:weather/model/convertModel.dart';
import 'package:weather/model/symbols.dart';

class Api{

  static getSymbolsName ()async{

    print("I am api");
    List sym=[];

    String url= 'https://currency-conversion-and-exchange-rates.p.rapidapi.com/symbols';

    var headers= {'x-rapidapi-host': 'currency-conversion-and-exchange-rates.p.rapidapi.com',
                  'x-rapidapi-key': '276c136368msh2f6f2dbaab61519p1c13e0jsnff020c9437d9'};
    var response = await http.get(Uri.parse(url),headers:headers);
    print(response.body);

    var lisy = jsonDecode(response.body)['symbols'];

    lisy.forEach((key,value){
      SymbolsModel a = SymbolsModel.fromJson(key,value);
      sym.add(a);

    });
    sym.sort((a,b)=>a.shortSymbols[0].compareTo(b.shortSymbols[0]));

    Global.symbols=sym;
    return Global.symbols;
    }


    static convert(from,to ,mount,date)async{
    print("I am convert $date" );
      var headers={
      'x-rapidapi-host': 'currency-conversion-and-exchange-rates.p.rapidapi.com',
      'x-rapidapi-key': '276c136368msh2f6f2dbaab61519p1c13e0jsnff020c9437d9'
      };

      var url2= 'https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert?from=$from&to=$to&amount=$mount&date=$date';

      var data=await http.get(Uri.parse(url2),headers: headers);
      print(data.body);
      var data2=jsonDecode(data.body);
      ConvertModel modelData=ConvertModel.fromJson(data2);
      print(modelData);
      Global.results=modelData;
      return Global.results;

    }


}