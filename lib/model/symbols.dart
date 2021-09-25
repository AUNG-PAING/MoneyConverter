class SymbolsModel{
  String shortSymbols,countryName;
  SymbolsModel(this.shortSymbols,this.countryName);
  factory SymbolsModel.fromJson(key,value){
    return SymbolsModel(key,value);
  }
}