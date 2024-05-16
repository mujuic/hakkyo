import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        border:Border.all(width: 2.5, color: Colors.white),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Center(
        child:Text(text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )
        )
      )
    );
  }
}