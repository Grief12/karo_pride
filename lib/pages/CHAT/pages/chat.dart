import 'package:b_social02/pages/CHAT/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser;

  //instance of auth
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.grey[900],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Please wait')],
              ),
            );
          }
          return ListView(
            children:
                snapshot.data!.docs.map((doc) => _buildUserItem(doc)).toList(),
          );
        });
  }

  //list user except current user
  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (currentUser!.email != data['email']) {
      return ListTile(
        title: Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 138, 137, 137),
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Icon(Icons.message_outlined),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['email']),
                    const SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: data['email'],
                receiverUid: data['uid'],
              ),
            ),
          );
        },
      );
    }
    return Container();
  }
}
