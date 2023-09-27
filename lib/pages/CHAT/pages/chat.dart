import 'package:b_social02/pages/CHAT/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: signOut,
          )
        ],
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
          return ListView(
            children:
                snapshot.data!.docs.map((doc) => _buildUserItem(doc)).toList(),
          );
        });
  }

  //list user except current user
  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (currentUser.email != data['email']) {
      return ListTile(
        title: Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 138, 137, 137),
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
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
                  children: [
                    Text(data['email']),
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

  //   return FutureBuilder(
  //       future: api.fetchChat(currentUser.email!),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //               itemCount: snapshot.data['akun'].length,
  //               itemBuilder: (context, index) {
  //                 final post = snapshot.data['akun'][index];
  //                 return FetchChat(
  //                   post['username'],
  //                   post['email'],
  //                   () {
  //                     //pass the clicked user
  //                     PersistentNavBarNavigator.pushNewScreen(
  //                       context,
  //                       withNavBar: false,
  //                       screen: ChatPage(
  //                         receiverUsername: post['username'],
  //                         receiverEmail: post['email'],
  //                       ),
  //                     );
  //                   },
  //                 );
  //               });
  //         }
  //         return Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [CircularProgressIndicator(), Text('Please wait')],
  //           ),
  //         );
  //       });
  // }
}
