import 'package:b_social02/components/Navbar.dart';
import 'package:b_social02/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';

void main() {
  runApp(const MaterialApp(
    home: Create(),
  ));
}

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final TextEditingController postController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  final _formkey = GlobalKey<FormState>();
  Api api = Api();

  //void
  void makePost() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          child: Container(
            child: Column(children: [
              const SizedBox(
                child: Padding(
                    padding: EdgeInsets.only(
                  top: 20,
                )),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: IconButton(
                            onPressed: () {
                              print('hello');
                            },
                            icon: Icon(Icons.add)))),
              ),
              const SizedBox(
                child: Padding(padding: EdgeInsets.only(bottom: 20)),
              ),
              Container(
                child: Row(
                  children: [
                    const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: postController,
                      minLines: 1,
                      maxLines: 9,
                      decoration: const InputDecoration(
                        hintText: 'Apa yang sedang kamu pikirkan?',
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          api
                              .post(currentUser.email!, postController.text, 0)
                              .then((value) {
                            print(value);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navbar()));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        icon: Icon(Icons.send)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
