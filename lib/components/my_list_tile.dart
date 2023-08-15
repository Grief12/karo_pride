import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title, text, value;
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.title,
    required this.text,
    required this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
