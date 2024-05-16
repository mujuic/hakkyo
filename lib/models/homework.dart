// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Homework {
  late String date;
  
  late String preview;
  
  late String text;
  
  late String id;

  Homework({
    required this.date,
    
    required this.preview,
    
    required this.text,
    
    required this.id,
  });

  Homework.fromHWUnit(String date_d, _id, Map<String,dynamic> hwUnit){

    date = date_d;
    
    preview = hwUnit["preview"];
    
    text = hwUnit["text"];
    
    id = _id.toString();
  }

  factory Homework.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Homework(
      date: data?['date'], 
      
      preview: data?['preview'], 
      
      text : data?['text'], 
      
      id: data?['id']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (date != null) "date": date,
      
      if (preview != null) "preview": preview,
      
      if (text != null) "text": text,
      
      if (id != null) "id": id
    };
  }

  Map<String, dynamic> toJson(){
    
    final r = {
      "date" : date,

      "preview" : preview,

      'text' : text,

      'id' : id,
    };
    
    return r;
  }

  Homework.fromJson(Map<String, dynamic> json){

    date = json["date"];

    preview = json["preview"];

    text = json["text"];

    id = json["id"];
  }
  
  String getInfo(){
    return "$preview";
  }
}
