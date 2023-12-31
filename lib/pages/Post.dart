import 'dart:io';
//import 'package:b_social02/pages/crop.dart';
import 'package:b_social02/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
  PlatformFile? pickedFile = null;
  String? imgUrl;

  Api api = Api();

  //void
  void postMassage() async {
    var doc = FirebaseFirestore.instance.collection("Likes").doc("tes");
    doc.set({
      'Likes': [],
    });
  }

  void insfoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });

      print(pickedFile!.name);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => Crop(image: pickedFile!)));
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

    final snapshot = await up.whenComplete(() {});

    final urlImg = await snapshot.ref.getDownloadURL();

    try {
      await snapshot;
      await urlImg;
      api.post(currentUser.email!, postController.text, 0, urlImg);
    } on firebase_storage.FirebaseStorage catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())),
        ),
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
                        child: pickedFile == null
                            ? IconButton(
                                onPressed: insfoto, icon: Icon(Icons.add))
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pickedFile = null;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      child: Image.file(
                                        File(pickedFile!.path ?? ''),
                                        width: 300,
                                        height: 300,
                                      ),
                                      padding: EdgeInsets.all(15),
                                    ),
                                    Text(pickedFile!.name)
                                  ],
                                ),
                              ))),
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
                        if (value!.isEmpty || pickedFile == null) {
                          return 'Harap isi foto dan kata-kata';
                        }

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
                          if (_formkey.currentState!.validate()) {
                            if (pickedFile == null &&
                                postController.text.isNotEmpty) {
                              print('a');
                              print(pickedFile!.name);
                              api.post(
                                  currentUser.email!, postController.text, 0);
                            } else if (pickedFile != null &&
                                postController.text.isNotEmpty) {
                              print('b');
                              await upFoto();
                              print('berhasil');
                              print(pickedFile!.name);
                            } else if (pickedFile != null &&
                                postController.text.isEmpty) {
                              print('c');
                              await upFoto();
                              print(pickedFile!.name);
                            }

                            pickedFile = null;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }

                          //Navigator.pop(context);
                          //Navigator.push(
                          //    context,
                          //    MaterialPageRoute(
                          //        builder: (context) => Navbar()));
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
