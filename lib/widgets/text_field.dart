import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.textControl,
    required this.text,
    required this.obscureFlag,
  });

  final bool obscureFlag;

  final TextEditingController textControl;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:20, top: 2),
      child: SizedBox(        
        width: 260,
        child: TextField(
          style : const TextStyle(fontSize: 20, color : Colors.white, ),
          obscureText: obscureFlag,
          controller: textControl,
          decoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 20, color : Colors.white, ),
            filled: true,
            fillColor: Colors.black,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.white, width: 2),
                
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
            labelText: text,
          ),
        ),
      ),
    );
  }
}