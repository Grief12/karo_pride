import 'package:flutter/material.dart';

class ChatBubble2 extends StatelessWidget {
  final String message;
  const ChatBubble2({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: message.split("firebasestorage.googleapis.com")[0] == "https://"
            ? Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(10),
                width: 300,
                height: 300,
                child: Image.network(message),
              )
            : Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ));
  }
}
