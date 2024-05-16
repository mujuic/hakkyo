
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:hakkyo/models/events.dart';
import 'package:hakkyo/models/homework.dart';
import 'dart:convert';
import 'package:hakkyo/models/mark.dart';
import 'package:hakkyo/models/subject.dart';


Future<dynamic> loginPost(String username, String password) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "content-type" : "application/x-www-form-urlencoded", 
      }
    )
  );

  const url = "https://app.eschool.center/ec-server/login";

  String hash = sha256.convert(utf8.encode(password)).toString();

  final response = await dio.post(url, data:{
    "username": username,
    "password" : hash,
    "device":'{"cliType":"web","cliVer":"v.495","pushToken":"ubkzcdhu5uEZvl6OI7V0rRWkTY6xt1crv3HOxb75R1sZwA7Z05kshSZl7plOliuz","deviceName":"Chrome","deviceModel":105,"cliOs":"Win32","cliOsVer":null}',
  });
  
  final data = response.headers["set-cookie"]?[0].split(';')[0];
  
  return data;
}

Future<dynamic> loginCheck(String username, String password) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "content-type" : "application/x-www-form-urlencoded", 
      }
    )
  );

  const url = "https://app.eschool.center/ec-server/login";

  String hash = sha256.convert(utf8.encode(password)).toString();

  final response = await dio.post(url, data:{
    "username": username,
    "password" : hash,
    "device":'{"cliType":"web","cliVer":"v.495","pushToken":"ubkzcdhu5uEZvl6OI7V0rRWkTY6xt1crv3HOxb75R1sZwA7Z05kshSZl7plOliuz","deviceName":"Chrome","deviceModel":105,"cliOs":"Win32","cliOsVer":null}',
  });
  
  final data = response.statusCode;
  
  return data;
}


Future<dynamic> getState(String cookie) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "cookie" : "$cookie; site_ver=app", 
      },
    ),
  );
  
  const url = "https://app.eschool.center/ec-server/state";

  final response = await dio.get(url);

  final r = response.data as Map<String,dynamic>;

  return r;
}


Future<dynamic> getCurrentTime(String cookie) async {
  final dio = Dio(
    BaseOptions(
      headers: {
        "cookie" : "$cookie; site_ver=app", 
      },
    ),
  );

  const url = "https://app.eschool.center/ec-server/srv/sysTime";

  final response = await dio.get(url);

  return response; 
}

Future<dynamic> getClass(String cookie, userId) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "cookie" : "$cookie; site_ver=app",
        "userId" : userId,
      }
    ),
  );

  String url = "https://app.eschool.center/ec-server/usr/getClassByUser?userId=$userId";

  final response = await dio.get(url);

  final data = response.data as List<dynamic>;

  final r = data[data.length-1];

  return r;
}

Future<dynamic> getMarks(String userId,eiId,cookie) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "userId" : userId,
        "eiId": eiId,
        "cookie":cookie,
      },
    ),
  );

  String url = "https://app.eschool.center/ec-server/student/getDiaryPeriod/?userId=$userId&eiId=$eiId";

  final response = await dio.get(url);

  final data = response.data as Map<String,dynamic>;

  List<dynamic> list = data["result"];

  List<Mark> r = [];

  list.forEach((element) {
    if(element["markVal"]!=null && element["markVal"]!="!"){
      Mark mark = Mark.fromJson(element);
      r.add(mark);
    }
  });
  
  // r.forEach((element) {print(element.getInfo());});
  
  return r;
}

Future<dynamic> getEvents(String userId,eiId,cookie) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "userId" : userId,
        "eiId": eiId,
        "cookie":cookie,
      },
    ),
  );

  String url = "https://app.eschool.center/ec-server/student/getDiaryPeriod/?userId=$userId&eiId=$eiId";

  final response = await dio.get(url);

  final data = response.data as Map<String,dynamic>;

  List<dynamic> list = data["result"];

  List<Event> t = [];

  list.forEach((element) {
    if(element["mktWt"]!=null){
      if(element["mktWt"]>0.5){
        //print(element["startDt"]);
        Event event = Event.fromJson(element);
        t.add(event);
      }
    }
  });
  
  // r.forEach((element) {print(element.getInfo());});
  
  return t;
}

Future<dynamic> getSubjects(String userId,eiId,cookie) async{
  final dio = Dio(
    BaseOptions(
      headers: {
        "userId" : userId,
        "eiId": eiId,
        "cookie":cookie,
      },
    ),
  );

  String url = "https://app.eschool.center/ec-server/student/getDiaryUnits/?userId=$userId&eiId=$eiId";

  final response = await dio.get(url);

  final data = response.data as Map<String,dynamic>;

  List<dynamic> list = data["result"];

  Map<String,dynamic> r={};
  
  Map<String,dynamic> subjUnitMap ={};

  List<String> unitList=[];

  list.forEach((element) {
    if(true){
      Subject sub = Subject.fromSubjUnit(element);
      String unitId = sub.unitId.toString();
      r[unitId] = sub;
      subjUnitMap[sub.unitName] = unitId;
      unitList.add(unitId);
    }
    
  });

  r["unitList"] = unitList;

  r["subjUnitMap"] = subjUnitMap;

  return r;
}


Future<dynamic> getDiaryPeriod(String userId, d1,d2,cookie) async {
  final dio = Dio(
    BaseOptions(
      headers: {
        "userId" : userId,
        "d1":d1,
        "d2":d2,
        "cookie" : "$cookie; site_ver=app",
      },
    ),
  );
  final String url = "https://app.eschool.center/ec-server/student/diary?userId=$userId&d1=$d1&d2=$d2"; 

  final response = await dio.get(url);

  final data = response.data as Map<String,dynamic>;

  List<dynamic> lessonList = data["lesson"];

  Map<String,dynamic> r = {};

  int marksForPeriod = data["user"][0]["mark"].length; r["marksForPeriod"] = marksForPeriod; 
  List<Homework> homework= []; r["homework"] = homework;

  for(int i = 0; i < lessonList.length;i++){
    for(int j =0; j< lessonList[i]["part"].length; j++){
      if(lessonList[i]["part"][j]["cat"]=="DZ" && lessonList[i]["part"][j]["variant"][0]["preview"] != null){
        Homework hw = Homework.fromHWUnit(lessonList[i]["date_d"], lessonList[i]["part"][j]["id"],  lessonList[i]["part"][j]["variant"][0]);
        r["homework"].add(hw);
      }
    }
  }

  return r;
}