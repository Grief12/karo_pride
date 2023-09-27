import 'package:b_social02/Api.dart';
import 'package:b_social02/components/bubblechat.dart';
import 'package:b_social02/components/bublechat2.dart';
import 'package:b_social02/components/textfield.dart';
import 'package:b_social02/pages/CHAT/service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  //final String receiverUsername;
  final String receiverEmail;
  final String receiverUid;

  const ChatPage({
    super.key,
    //required this.receiverUsername,
    required this.receiverEmail,
    required this.receiverUid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessages(
          widget.receiverUid, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.receiverEmail,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //messages
          Expanded(
            child: _buildMessageList(),
          ),
          //input
          _buildMessageInput(),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  //list message
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUid, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? ChatBubble2(message: data['message'])
                : ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  //input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //textfield
        SizedBox(width: 8),
        Expanded(
            child: MyTextField(
          controller: _messageController,
          hintText: 'Pesan..',
          obscureText: false,
        )),

        //button
        IconButton(
          padding: EdgeInsets.all(10.0),
          onPressed: sendMessage,
          icon: Icon(
            Icons.arrow_upward,
            size: 30,
          ),
        )
      ],
    );
  }
}
