import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//import 'package:b_social02/components/Navbar.dart';
//import 'package:b_social02/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:file_picker/file_picker.dart';

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
  PlatformFile? pickedFile;
  String? imgUrl;

  Api api = Api();

  //void
  Future insfoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    } else {
      // User canceled the picker
      setState(() {
        pickedFile = null;
      });
    }
  }

  void messg() async {
    print('hello');
  }

  Future upFoto() async {
    File file = File(pickedFile!.path!);
    String filename = pickedFile!.name;
    String ext = pickedFile!.extension!;
    final ref =
        await firebase_storage.FirebaseStorage.instance.ref('$filename.$ext');
    final up = ref.putFile(file);

    final snapshot = await up;

    final urlImg = await snapshot.ref.getDownloadURL();

    try {
      up.whenComplete(() {
        setState(() {
          imgUrl = urlImg;

          if (_formkey.currentState!.validate()) {
            if (pickedFile == null && postController.text.isNotEmpty) {
              print('a');
              api.post(currentUser.email!, postController.text, 0);
            }
            if (pickedFile != null && postController.text.isNotEmpty) {
              print('b');
              print(pickedFile!.name);
              api.post(currentUser.email!, postController.text, 0, imgUrl);
            }
            if (pickedFile != null && postController.text.isEmpty) {
              print('c');
              api.post(currentUser.email!, null, 0, imgUrl);
            }
          }
        });
      });
    } on firebase_storage.FirebaseStorage catch (e) {
      print(e);
    }
  }

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
                            onPressed: () async {
                              insfoto();
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
                      validator: (value) {
                        if (value!.isEmpty && pickedFile == null) {
                          return 'Harap isi foto atau kata-kata';
                        }
                        ;
                        return null;
                      },
                      minLines: 1,
                      maxLines: 9,
                      decoration: const InputDecoration(
                        hintText: 'Apa yang sedang kamu pikirkan?',
                      ),
                    )),
                    IconButton(
                        onPressed: () async {
                          upFoto;

                          print('berhasil');
                          setState(() {
                            pickedFile = null;
                          });
                          Navigator.pop(context);
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
