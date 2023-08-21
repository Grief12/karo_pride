import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String text;
  final String icon;
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        onTap: onTap,
        title: Column(
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              text,
            )
          ],
        ),
      ),
    );
  }
}
