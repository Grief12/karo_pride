import 'package:flutter/material.dart';

class FetchChat extends StatefulWidget {
  final String username;
  final String msg;

  const FetchChat(this.username, this.msg);

  @override
  State<FetchChat> createState() => _FetchChatState();
}

class _FetchChatState extends State<FetchChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(Icons.message_outlined),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.username),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.msg,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
        ],
      ),
    );
  }
}
