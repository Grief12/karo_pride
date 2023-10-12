import 'package:flutter/material.dart';

class Crop extends StatelessWidget {
  final image;

  const Crop({
    super.key,
    required this.image,
  });

  //void crop() async {
  //  CroppedFile croppedFile = await ImageCropper().cropImage(
  //    sourcePath: image.path,
  //    aspectRatioPresets: [
  //      CropAspectRatioPreset.square,
  //      CropAspectRatioPreset.ratio3x2,
  //      CropAspectRatioPreset.original,
  //      CropAspectRatioPreset.ratio4x3,
  //      CropAspectRatioPreset.ratio16x9
  //    ],
  //    uiSettings: [
  //      AndroidUiSettings(
  //          toolbarTitle: 'Cropper',
  //          toolbarColor: Colors.deepOrange,
  //          toolbarWidgetColor: Colors.white,
  //          initAspectRatio: CropAspectRatioPreset.original,
  //          lockAspectRatio: false),
  //      IOSUiSettings(
  //        title: 'Cropper',
  //      ),
  //      WebUiSettings(
  //        context: context,
  //      ),
  //    ],
  //  );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Container(
          child: Center(
        child: Column(
          children: [Image(image: AssetImage(image))],
        ),
      )),
    );
  }
}
