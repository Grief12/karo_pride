import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Create(),
  ));
}

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('tes'),
      ),
    );
  }
}
