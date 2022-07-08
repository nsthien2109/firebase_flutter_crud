import 'package:flutter/material.dart';

void showTextMessage(context,message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
       backgroundColor: Colors.orange,
       content: Text(message,
        style: const TextStyle(
          color: Colors.white
        ),
       ),
   ));
}