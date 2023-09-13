import 'package:b_social02/Api.dart';
import 'package:b_social02/components/bubble_chat.dart';
//import 'package:b_social02/components/bubble_chat.dart';
import 'package:b_social02/pages/chat/message.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  final int receiverid;
  const ChatPage({
    super.key,
    required this.receiverUsername,
    required this.receiverid,
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
            child: _buildMessageList(),
          ),
        ],
      ),
    );
  }

  //list message
  Widget _buildMessageList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: api.getChat(currentUser.email!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data['data'][index];
                      return Message(
                        post['message'],
                        post['created_at'],
                      );
                    },
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Please wait')
                    ],
                  ),
                );
              },
            ),
          ),
          //textfield
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: TextFormField(
                      controller: postController,
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
                          .postChat(
                        currentUser.email!,
                        postController.text,
                        widget.receiverid,
                      )
                          .then((value) {
                        postController.clear();
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
