import 'package:b_social02/components/bubble_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final String message;
  final String time;
  const Message(
    this.message,
    this.time,
  );

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(25),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ChatBubble(message: widget.message),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.time,
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
          ],
        ),
      ),
    );
  }

  //align
  Widget _buildMessageItem(String email, String receiverEmail) {
    var alignment =
        receiverEmail == email ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          ChatBubble(message: widget.message),
          Text(widget.time),
        ],
      ),
    );
  }
}
