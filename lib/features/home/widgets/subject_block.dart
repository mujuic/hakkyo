// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/models/events.dart';
import 'package:hakkyo/models/subject.dart';
import 'package:hakkyo/widgets/my_text.dart';

class SubjectBlock extends StatelessWidget {
  SubjectBlock({
    super.key,
    required this.sub,
    required this.index,
    required this.events,
  });

  TextEditingController markField = TextEditingController();

  TextEditingController coeffField = TextEditingController();

  List<String> smileList = [
    "(´･ᴗ･ )",
    "٩(｡•́‿•̀｡)۶",
    '( ‾́ ◡ ‾́ )',
    "(ﾉ´ヮ)ﾉ",
  ];

  final Subject sub;

  final int index;

  final List<Event> events;

  @override
  Widget build(BuildContext context) {

    int qounty = 0;

    for(int i =0; i < events.length; i++){
      if(events[i].unitId == sub.unitId){
        qounty++;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 50, top: 50, bottom: 70),
      child: Container(
          height: 120,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(width: 2.5, color: Colors.white),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UnitName(sub: sub),

              OMButton(sub: sub),
              
              SubjectBlockUnit(text: sub.rating != "!"? "rating : ${sub.rating}": 'rating : ${smileList[index % 4]}'),

              Schedule(count: qounty),

              Scroll(events: events, sub: sub),
            ],
          )),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({
    super.key,
    required this.sub,
  });

  final Subject sub;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  TextEditingController markField = TextEditingController();

  TextEditingController coeffField = TextEditingController();

  late double overMark;

  late double coefficientSum;

  @override
  void initState() {
    overMark = widget.sub.overMark;
    coefficientSum = widget.sub.coefficientSum;
    super.initState();
  }

 void testMark(){
    double coeffTest = double.parse(coeffField.text);

    double markTest = double.parse(markField.text);
  
    double rd = (coefficientSum*overMark+markTest*coeffTest)/(coefficientSum+coeffTest)*100;

    int ri = rd.round();

    coefficientSum += coeffTest;

    overMark = ri/100.0;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 135, 135, 135),
            border: Border.all(
                width: 3, color: Colors.white),
            //borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SubjectTextField(
                      textControl: markField,
                      text: "mark"),
                  SubjectTextField(
                      textControl: coeffField,
                      text: "coefficient"),
                ],
              ),
              GestureDetector(
                onTap: () {setState(() {
                  testMark();
                });},
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 40),
                  child: Icon(Icons.input),
                ),
              ),
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 135, 135, 135),
                    border: Border.all(
                        width: 3, color: Colors.white),
                    //borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(overMark.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      )))
            ],
          )),
    );
  }
}

class OMButton extends StatefulWidget {
  const OMButton({
    super.key,
    required this.sub,
  });

  
  final Subject sub;

  @override
  State<OMButton> createState() => _OMButtonState();
}

class _OMButtonState extends State<OMButton> {

  

  @override
  Widget build(BuildContext context) {
    return TextButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return MyDialog(sub:widget.sub);
                });
          },
          child:
              SubjectBlockUnit(text: "overMark : ${widget.sub.overMark}")
      );
  }
}

class UnitName extends StatelessWidget {
  const UnitName({
    super.key,
    required this.sub,
  });

  final Subject sub;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 2.5, color: Colors.white),
        ),
        child: Center(
          child: Text(sub.unitName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )
          )
        )
      ),
    );
  }
}

class Schedule extends StatelessWidget {
  const Schedule({
    super.key,
    required this.count,
  });

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
          width: 150,
          height: 25,
          decoration: const BoxDecoration(
            color: Colors.black,
            border: Border(
                top: BorderSide(width: 1.5, color: Colors.white),
                left: BorderSide(width: 1.5, color: Colors.white),
                right: BorderSide(width: 1.5, color: Colors.white)),
          ),
          child: Center(
            child: Text("schedule : $count",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )
            )
          )
      ),
    );
  }
}

class Scroll extends StatelessWidget {
  const Scroll({
    super.key,
    required this.events,
    required this.sub,
  });

  final List<Event> events;

  final Subject sub;

  @override
  Widget build(BuildContext context) {
    
    List<int> indexList=[];

    List<int> indexListbackW=[];

    for(int i =0; i < events.length; i++){
      if(events[i].unitId == sub.unitId){
        indexList.add(i);
      }
    }

    for(int i = indexList.length-1; i >=0; i--){
      indexListbackW.add(indexList[i]);
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: //Border.all(width: 1.5, color: Colors.white),
            Border(
                bottom: BorderSide(width: 1.5, color: Colors.white),
                left: BorderSide(width: 1.5, color: Colors.white),
                right: BorderSide(width: 1.5, color: Colors.white)),
      ),
      height: 135,
      width: 150,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: indexListbackW.length,
        itemBuilder: (context, index) {
          return EventText(event: events[indexListbackW[index]]);
        },
      ),
    );
  }
}

class EventText extends StatelessWidget {
  const EventText({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        decoration: const BoxDecoration(
        color: Colors.black,
        border: //Border.all(width: 1.5, color: Colors.white),
          Border(bottom: BorderSide(width: 1.5, color: Colors.white)),
        ),
        child: Column(
          children: [
            MyTextS(text:"${event.lptName}",color: Colors.white),
            MyTextS(text: "вес: ${event.mktWt}",color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: MyTextS(text: event.markVal =="!" ? "будет проведена: ${event.startDt.split("T")[0]}" : "оценка: ${event.markVal}", color: Colors.white),
            ),
            
            //MyTextS(text: "дата: ${event.startDt}",color: Colors.white),
          ]
        )
      )
    );
  }
}
class MyTextS extends StatelessWidget {
  const MyTextS({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      )
    );
  }
}

class SubjectBlockUnit extends StatelessWidget {
  const SubjectBlockUnit({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: 150,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(width: 1.5, color: Colors.white),
            //borderRadius: BorderRadius.circular(5)
          ),
          child: Center(
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )))),
    );
  }
}

class SubjectTextField extends StatelessWidget {
  const SubjectTextField({
    super.key,
    required this.textControl,
    required this.text,
  });

  final TextEditingController textControl;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2, top: 2),
      child: SizedBox(
        width: 70,
        height: 30,
        child: TextField(
          style: const TextStyle(fontSize: 10, color: Colors.black),
          controller: textControl,
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            hintText: text,
          ),
        ),
      ),
    );
  }
}
