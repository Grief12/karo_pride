import 'package:b_social02/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;

  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Colors.grey[900],
      ),
      body: _buildUserList(),
    );
  }

  //list user except current user
  Widget _buildUserList() {
    return FutureBuilder(
      future: api.chat(currentUser.email!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  //build individual user list
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = api.fetchUser() as Map<String, dynamic>;

    //display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: data['username'],
        onTap: () {
          //to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUsername: data['username'],
                receiverUserId: data['akuns_id'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
