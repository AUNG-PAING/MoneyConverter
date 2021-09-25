
class ConvertModel{
        var info;
        var  quary;
        String date,result;

        ConvertModel(this.info,this.quary,this.date,this.result);
        factory ConvertModel.fromJson(data){
          var quarys =queryModel.fromJson(data['query']);
          var infos =infoModel.fromJson(data['info']);
          return ConvertModel(

              infos,
              quarys,
              data["date"],
              data['result'].toString());
        }
}

class queryModel{
  String from,to,amount;
  queryModel(this.from,this.to,this.amount);
  factory queryModel.fromJson(dynamic data){
    return queryModel(data['from'],data['to'],data['amount'].toString());
  }
}



class infoModel{

  String time,rate;

  infoModel(this.time,this.rate);
  factory infoModel.fromJson(data){
    return infoModel(data['timestamp'].toString(),data['rate'].toString());
  }


}