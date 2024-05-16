// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hakkyo/models/events.dart';

import 'package:hakkyo/models/homework.dart';
import 'package:hakkyo/models/mark.dart';
import 'package:hakkyo/models/subject.dart';

class User {
  
  String eiId = "406053";

  late String userId;

  late String name;

  late String groupId;

  late String groupName;

  late String yearId;

  late String cookie;

  late List<Mark> marks;

  late Map<String, dynamic> subjects;

  late List<String> unitList;
  
  late Map<String, dynamic> subjUnitMap;

  late List<Homework> homework;

  late List<Event> events;

  User({
    required this.eiId,
    
    required this.userId,
    
    required this.name,
    
    required this.groupId,
    
    required this.groupName,
    
    required this.yearId,
    
    required this.cookie,
    
    required this.marks,
    
    required this.subjects,
    
    required this.unitList,
    
    required this.subjUnitMap,
    
    required this.homework,

    required this.events,
  });

  //late Map<String,dynamic> diaryPeriod;

  String getInfo(){
    return "$userId, $name, $groupId, $groupName, $yearId";
  }

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return User(
      eiId: data?['eiId'], 
      
      userId: data?['userId'], 
      
      name : data?['name'], 
      
      groupId: data?['groupId'],

      groupName: data?['groupName'], 
      
      yearId: data?['yearId'], 
      
      cookie : data?['cookie'], 
      
      marks: data?['marks'],

      subjects: data?['subjects'], 
      
      unitList: data?['unitList'], 
      
      subjUnitMap : data?['subjUnitMap'], 
      
      homework: data?['homework'],

      events: data?['events'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (eiId != null) "eiId": eiId,
      
      if (userId != null) "userId": userId,
      
      if (name != null) "name": name,
      
      if (groupId != null) "groupId": groupId,

      if (groupName != null) "groupName": groupName,
      
      if (yearId != null) "yearId": yearId,
      
      if (cookie != null) "cookie": cookie,
      
      if (marks != null) "marks": marks,

      if (subjects != null) "subjects": subjects,
      
      if (unitList != null) "unitList": unitList,
      
      if (subjUnitMap != null) "subjUnitMap": subjUnitMap,
      
      if (homework != null) "homework": homework,
    };
  }


  User.fromJson(Map<String, dynamic> json){
    //получаем данные из json
    userId = json["userId"];

    name = json["name"];

    groupId = json["groupId"];

    groupName = json["groupName"];

    yearId = json["yearId"];

    //превращаем словари в класс оценок
    final jsonMarks = json["marks"]; final List<Mark> _marks = [];

    jsonMarks.forEach((element){
      _marks.add(Mark.fromJson(element));

    }); marks = _marks;

    //превращаем словари в класс предметов
    final jsonSubjects = json["subjects"]; final Map<String,dynamic> _subjects = {};

    jsonSubjects.forEach((key, value){
      _subjects[key] = Subject.fromJson(value);

    }); subjects = _subjects;

    subjUnitMap = json["subjUnitMap"];

    unitList = List<String>.from(json["unitList"]);

    //превращаем словари в класс дз
    final jsonHomework = json["homework"]; final List<Homework> _homework = [];

    jsonHomework.forEach((element){
      _homework.add(Homework.fromJson(element));

    }); homework = _homework;

    final jsonEvents = json['events']; final List<Event> _events = [];
    
    jsonEvents.forEach((element){
      _events.add(Event.fromJson(element));
      print("111");
      
    }); events = _events;

    //diaryPeriod = json["diaryPeriod"];
  }

  Map<String, dynamic> toJson(){
    //превращаем в json
    final r = {
      "userId" :userId,

      "name" :name,

      "groupId" :groupId,

      "groupName" :groupName,

      "yearId": yearId,

      "marks" : marks,

      "subjects" : subjects,

      "subjUnitMap" : subjUnitMap,

      "unitList" : unitList,

      "homework" : homework,

      "events" : events,

      //"diaryPeriod" : diaryPeriod,
    };

    return r;
  }

  String getSubjects(int index){
    return subjects[unitList[index]].unitName;
  }
  
  

}
