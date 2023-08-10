import 'package:b_social02/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'Post.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api api = Api();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfile,
        onSignOut: signOut,
      ),
      body: FutureBuilder(
          future: api.getPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data['data'][index];
                    return Text(post['message']);
                  });
            }

            return Center(child: Text('Tidak terhubung ke internet'));
          }),
  }
}
