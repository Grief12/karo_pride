import 'package:b_social02/pages/chat/chat_page.dart';
import 'package:b_social02/pages/chat/chat_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  //instance of auth
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
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
                itemCount: snapshot.data['akun'].length,
                itemBuilder: (context, index) {
                  final post = snapshot.data['akun'][index];
                  return FetchChat(
                    post['username'],
                    post['message'],
                    post['penerima_id'],
                    () {
                      //pass the clicked user
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: ChatPage(
                          receiverUsername: post['username'],
                          receiverid: post['penerima_id'],
                        ),
                      );
                    },
                  );
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
