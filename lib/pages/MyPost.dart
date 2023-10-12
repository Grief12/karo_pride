import 'package:b_social02/components/post.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  //sign out
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> refresh() {
    setState(() {
      FutureBuilder(
          future: api.getMyPost(currentUser.email!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data']['post'].length,
                  itemBuilder: (context, index) {
                    final like = snapshot.data['data']['like'];
                    final post = snapshot.data['data']['post'][index];
                    return FetchPost(
                        post['id'],
                        post['profile'],
                        post['username'],
                        post['message'],
                        post['imgurl'],
                        post['likes'],
                        post['email'],
                        like);
                  });
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("Belum ada postingan, post lah sesuatu"),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Please wait')],
              ),
            );
          });
    });
    return api.getPost();
  }

  //Navigate To Profile Page
  void goToProfile() {
    //pop menu drawer
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Post saya"),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: api.getMyPost(currentUser.email!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                child: ListView.builder(
                    itemCount: snapshot.data['data']['post'].length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data['data']['post'][index];
                      final like = snapshot.data['data']['like'];

                      return FetchPost(
                          post['id'],
                          post['profile'],
                          post['username'],
                          post['message'],
                          post['imgurl'],
                          post['likes'],
                          post['email'],
                          like);
                    }),
                onRefresh: refresh,
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text('Please wait')],
              ),
            );
          }),
    );
  }
}
