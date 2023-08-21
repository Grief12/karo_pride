import 'package:b_social02/components/chat_style.dart';
import 'package:b_social02/pages/chat_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
        future: api.fetchChat(currentUser.email!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  final post = snapshot.data['data'][index];
                  return FetchChat(post['username'], post['message']);
                });
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(), Text('Please wait')],
            ),
          );
        });
  }
}
