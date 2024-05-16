class Event{
  late String startDt;
  
  late double mktWt;
  
  late String unitId;
  
  late String lptName;

  late String markVal;

  Event.fromJson(Map<String,dynamic> json){
    mktWt = json['mktWt'];
    
    unitId = json['unitId'].toString();
    
    startDt = json["startDt"];

    json["lptName"] != null ? lptName = json["lptName"] : lptName ="!";

    json["markVal"] != null ? markVal = json["markVal"] : markVal ="!";
  }

  Map<String, dynamic> toJson(){
    final r = {
      "mktWt" : mktWt,

      "unitId" : unitId,

      "startDt" : startDt,

      "lptName" : lptName,

      "markVal" : markVal
    };

    return r;
  }
}