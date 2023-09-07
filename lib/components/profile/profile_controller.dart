import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../Api.dart';
import '../profile_textfield.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final nameFocusNode = FocusNode();
  final bioFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  final currentUser = FirebaseAuth.instance.currentUser!;
  //DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  Api api = Api();
  firebase_storage.FirebaseStorage storage = firebase_storage
      .FirebaseStorage.instance as firebase_storage.FirebaseStorage;
  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = await XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.camera,
                    color: Colors.black,
                  ),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  title: Text('Gallery'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileimage' + currentUser.email!);
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();

    api.updatepp(newUrl, currentUser.email!.toString()).then((value) {
      setLoading(false);
      _image = null;
    }).onError((error, StackTrace) {
      setLoading(false);
    });
  }

//edit name/
  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update UserName')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: ProfileTextField(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      onFiledSubmittedValue: (value) {},
                      keyBoardType: TextInputType.text,
                      obscureText: false,
                      hintText: 'Enter Name',
                      onValidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "UserName Tidak Boleh Kosong";
                        }
                        ;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  api
                      .updateusernames(nameController.text, currentUser.email!)
                      .then((value) {
                    nameController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black),
                ),
              )
            ],
          );
        });
  }

//edit bio
  Future<void> showbioDialogAlert(BuildContext context, String bio) {
    bioController.text = bio;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update Bio')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileTextField(
                    controller: bioController,
                    focusNode: bioFocusNode,
                    onFiledSubmittedValue: (value) {},
                    keyBoardType: TextInputType.text,
                    obscureText: false,
                    hintText: 'Enter Bio',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  api
                      .updatebio(bioController.text, currentUser.email!)
                      .then((value) {
                    bioController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Ok',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black),
                ),
              )
            ],
          );
        });
  }
}
