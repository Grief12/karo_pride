import 'package:flutter/material.dart';

class FetchPost extends StatefulWidget {
  final String username;
  final String msg;

  const FetchPost(this.username, this.msg);

  @override
  State<FetchPost> createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.people),
              Column(
                children: [
                  Text(widget.username),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.msg),
                ],
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
  }
}
