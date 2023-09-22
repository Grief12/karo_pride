import 'package:b_social02/components/post.dart';
import 'package:b_social02/pages/Post.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //sign out
  Api api = Api();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> refresh() {
    setState(() {
      FutureBuilder(
          future: api.getPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data']['post'].length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data['data']['post'][index];
                    final like = snapshot.data['data']['like'];
                    return FetchPost(
                        post['id'],
                        post['username'],
                        post['message'],
                        post['imgurl'],
                        post['likes'],
                        post['email'],
                        like);
                  });
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
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.send),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Create()));
        },
      ),
      body: FutureBuilder(
          future: api.getPost(),
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
