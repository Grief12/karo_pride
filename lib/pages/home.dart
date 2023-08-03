
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
  //sign out
  Api api = Api();
  void signOut() {
    FirebaseAuth.instance.signOut();
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
        foregroundColor: Colors.white,
        title: const Icon(Icons.add), //drawer disini
        actions: <Widget>[
          IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfile,
        onSignOut: signOut,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.people),
                      Column(
                        children: [
                          const Text('ini akun'),
                          const Text('ini image'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Create()));
        api.getPost().then((value) {
          print(value);
        });
      }),
    );
  }
}
