import 'dart:io';
import 'package:b_social02/pages/profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../Api.dart';
import '../profile_textfield.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final nameFocusNode = FocusNode();
  final bioFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  final currentUser = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;
  //DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  Api api = Api();
  firebase_storage.Reference storage =
      firebase_storage.FirebaseStorage.instance.ref('profileimage/');
  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void pickGalleryImage(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (result != null) {
      pickedFile = result.files.first;

      await upFoto();

      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: Profile(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );

      print(pickedFile!.name);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => Crop(image: pickedFile!)));
    } else {
      // User canceled the picker
    }
  }

  Future upFoto() async {
    File file = File(pickedFile!.path!);
    String filename = pickedFile!.name;
    String ext = pickedFile!.extension!;
    final ref = await firebase_storage.FirebaseStorage.instance
        .ref('profileimage/' + '$filename.$ext');
    final up = ref.putFile(file);

    final snapshot = await up.whenComplete(() {});

    final urlImg = await snapshot.ref.getDownloadURL();

    try {
      await snapshot;
      await urlImg;
      api.updatepp(urlImg, currentUser.email!);
    } on firebase_storage.FirebaseStorage catch (e) {
      print(e);
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
            height: 60,
            child: Column(
              children: [
                // ListTile(
                //   onTap: () {
                //     pickCameraImage(context);
                //     Navigator.pop(context);
                //   },
                //   leading: Icon(
                //     Icons.camera,
                //     color: Colors.black,
                //   ),
                //   title: Text('Camera'),
                // ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Profile()));
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
  Future<void> showUserNameDialogAlert(
    BuildContext context,
    String name,
  ) {
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
                    VoidCallback;
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
  Future<void> showbioDialogAlert(
    BuildContext context,
    String bio,
  ) {
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
