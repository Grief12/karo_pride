import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        onTap: onTap,
      ),
    );
  }
}
