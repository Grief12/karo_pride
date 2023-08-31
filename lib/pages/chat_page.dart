import 'package:b_social02/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  const ChatPage({
    super.key,
    required this.receiverUsername,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.receiverUsername,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'status',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      minLines: 1,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        hintText: 'Pesan...',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                    onPressed: () {
                      api
                          .post(currentUser.email!, postController.text, 0)
                          .then((value) {
                        print(value);
                      });
                    },
                    icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
