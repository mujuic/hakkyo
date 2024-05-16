// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Mark {

  late int markValId; // 7 = "!";

  late double mktWt;

  late String teachFio;

  late String subject;

  late String markDate;

  // late String lesNote;

  late String lptName;

  late String unitId;

  Mark({
    required this.markValId,
    
    required this.mktWt,
    
    required this.teachFio,
    
    required this.subject,
    
    required this.markDate,
    
    required this.lptName,
    
    required this.unitId,
  });

  factory Mark.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Mark(
      markValId: data?['markValId'], 
      
      mktWt: data?['mktWt'], 
      
      teachFio: data?['teachFio'], 
      
      subject: data?['subject'], 
      
      markDate: data?['markDate'], 
      
      lptName: data?['lptName'], 
      
      unitId: data?['unitId']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (markValId != null) "markValId": markValId,
      
      if (mktWt != null) "mktWt": mktWt,
      
      if (unitId != null) "unitId": unitId,
      
      if (teachFio != null) "teachFio": teachFio,
      
      if (markDate != null) "markDate": markDate,
      
      if (lptName != null) "lptName": lptName,
      
      if (unitId != null) "unitId": unitId,
    };
  }

  Mark.fromJson(Map<String,dynamic> unit){

    markValId = unit["markValId"];

    mktWt = unit["mktWt"];

    teachFio = unit["teachFio"];

    subject = unit["subject"];

    markDate = unit["markDate"];

    // lesNote = unit["lesNote"];

    lptName = unit["lptName"];

    unitId = unit["unitId"].toString();
  }

  Map<String,dynamic> toJson(){
    final r = {
      "markValId" : markValId,  

      "mktWt": mktWt,

      "teachFio" : teachFio,

      "subject": subject,

      "markDate" :markDate,

      // "lesNote" : lesNote,

      "lptName" : lptName,

      "unitId" : unitId,
    };

    return r;
  }

  String getInfo(){
    return "You got $markValId, with coefficient $mktWt. Marked by $teachFio";
  }
  
}

