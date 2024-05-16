// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hakkyo/models/events.dart';

class Subject {
  late double overMark;

  late String rating;
  
  late String unitId;
  
  late String unitName;
  
  late String sugTotalMark;
  
  int markNum = 0;
  
  double coefficientSum = 0.0;

  List<Event> eventList = [];

  Subject({
    required this.overMark,
    
    required this.rating,
    
    required this.unitId,
    
    required this.unitName,
    
    required this.sugTotalMark,
    
    required this.markNum,
    
    required this.coefficientSum,
  });

  Subject.fromSubjUnit(Map<String,dynamic> subUnit){

    subUnit["rating"]==null ? rating = "!" : rating = subUnit["rating"];  

    subUnit["overMark"]==null ? overMark = 0 : overMark = subUnit["overMark"];

    subUnit["unitId"]==null ? unitId = "!" : unitId = subUnit["unitId"].toString();

    subUnit["unitName"]==null ? unitName = "!" : unitName = subUnit["unitName"];

    subUnit["sugTotalMark"]==null ? sugTotalMark = "!" : sugTotalMark = subUnit["sugTotalMark"];


  }

  factory Subject.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Subject(
      overMark: data?['overMark'], 
      
      rating: data?['rating'], 
      
      unitId: data?['unitId'], 
      
      unitName: data?['unitName'], 
      
      sugTotalMark: data?['sugTotalMark'], 
      
      markNum: data?['markNum'], 
      
      coefficientSum: data?['coefficientSum']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (overMark != null) "overMark": overMark,
      
      if (rating != null) "rating": rating,
      
      if (unitId != null) "unitId": unitId,
      
      if (unitName != null) "unitName": unitName,
      
      if (sugTotalMark != null) "sugTotalMark": sugTotalMark,
      
      if (markNum != null) "markNum": markNum,
      
      if (coefficientSum != null) "coefficientSum": coefficientSum,
    };
  }

  Subject.fromJson(Map<String,dynamic> subUnit){

    overMark = subUnit["overMark"];

    rating = subUnit["rating"];

    unitId = subUnit["unitId"].toString();

    unitName = subUnit["unitName"];

    sugTotalMark = subUnit["sugTotalMark"]; 

    markNum = subUnit["markNum"];

    coefficientSum = subUnit["coefficientSum"];
  }

  Map<String, dynamic> toJson(){

    final r = {
      "overMark" : overMark,

      "rating" : rating,

      "unitId" : unitId,

      "unitName" :  unitName,

      "sugTotalMark" : sugTotalMark,

      "markNum" : markNum,

      "coefficientSum" : coefficientSum,
    };

    return r;
  }

  // void update(int mark, double coefficient){
  //   markNum++;
  //   coefficientSum += coefficient;
  //   double rd = (coefficientSum*overMark+mark*coefficient)/(coefficientSum+coefficient)*100;
  //   int ri = rd.round();
  //   overMark = ri/100.0;
  // }

  void incrementNum(){
    markNum++;
  }

   void incrementCoefficientSum(double coefficient){
    coefficientSum += coefficient;
  }
  
  String getInfo(){
    return "Sbj: $unitName, you have $markNum marks. Average mark $overMark";
  }

  double testMark(int mark, double coefficient){
    double rd = (coefficientSum*overMark+mark*coefficient)/(coefficientSum+coefficient)*100;
    int ri = rd.round();
    return ri/100.0;
  }
}
