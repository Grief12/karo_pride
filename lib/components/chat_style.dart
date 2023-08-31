import 'package:b_social02/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchChat extends StatefulWidget {
  final String username;
  final String msg;
  final void Function()? onTap;

  const FetchChat(
    this.username,
    this.msg,
    this.onTap,
  );

  @override
  State<FetchChat> createState() => _FetchChatState();
}

class _FetchChatState extends State<FetchChat> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverUsername: widget.username,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(25),
        child: Container(
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
        ),
      ),
    );
  }
}
