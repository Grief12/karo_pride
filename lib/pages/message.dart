import 'package:flutter/material.dart';

class MyMessage extends StatefulWidget {
  final String mymessage;
  final String othermessage;

  const MyMessage(
    this.mymessage,
    this.othermessage,
  );

  @override
  State<MyMessage> createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
