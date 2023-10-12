import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: message.split("firebasestorage.googleapis.com")[0] == "https://"
            ? Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                width: 300,
                height: 300,
                child: Image.network(message),
              )
            : Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ));
  }
}
