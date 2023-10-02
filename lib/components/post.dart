import 'package:b_social02/Api.dart';
import 'package:b_social02/components/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/pages/Comment.dart';
import 'package:b_social02/pages/PostProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class FetchPost extends StatefulWidget {
  final int id;
  final profile;
  final String username;
  final String msg;
  final String img;
  final int like;
  final String email;
  final List arrLikes;
  const FetchPost(this.id, this.profile, this.username, this.msg, this.img,
      this.like, this.email, this.arrLikes);

  @override
  State<FetchPost> createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {
  late int likes = widget.like;
  late int posId = widget.id;
  final currentUser = FirebaseAuth.instance.currentUser!;
  String? user;
  var arrData;
  late List likearrConf = widget.arrLikes
      .where((element) => element['post_id'] == widget.id)
      .toList();
  bool pressed = true;

  searchData() {
    for (int i = 0; i < likearrConf.length; i++) {
      if (currentUser.email == likearrConf[i]['email']) {
        return likearrConf[i]['email'];
      }
    }
  }

  Future download(String urlImg) async {
    print("method start");
    var extDir = await getExternalStorageDirectory();
    print("method di eksekusi");
    var dio = Dio();
    var result = await dio.get<List<int>>(urlImg,
        options: Options(responseType: ResponseType.bytes));
    if (result.statusCode == 200) {
      var byteDownloaded = result.data;
      if (byteDownloaded != null) {
        var file = File("${extDir!.path}/b_social02.jpg");
        file.writeAsBytesSync(byteDownloaded);
        return "file berhasil di save ke ${file.path}";
      } else {
        print("file kosong");
        return "error file kosong";
      }
    } else {
      return "download error";
    }
    if (extDir != null) {
    } else {
      print("direktori kosong");
      return "error";
    }
  }

  @override
  void initState() {
    super.initState();
    arrData = searchData();
    pressed = arrData == currentUser.email ? false : true;
    user = currentUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        width: 500,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: widget.profile == null
                          ? Icon(
                              Icons.person,
                              size: 25,
                            )
                          : Image.network(
                              widget.profile,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(widget.username),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostProfile(widget.email)));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) => Padding(
                                    padding: EdgeInsets.all(20),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      onLongPress: () => showDialog(
                                          context: context,
                                          builder: (context) => Center(
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      print("Download");
                                                      await launchUrl(
                                                          Uri.parse(widget.img),
                                                          mode: LaunchMode
                                                              .externalApplication);
                                                      //download(widget.img);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      color: Colors.white,
                                                      width: 225,
                                                      height: 75,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(Icons
                                                                  .download),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                  "Download",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    )),
                                              )),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Container(
                                          child: Image.network(
                                            widget.img,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                          child: Container(
                            width: 300,
                            height: 200,
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child:
                                  Image.network(widget.img, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  print(pressed);
                                  pressed = !pressed;
                                  print(pressed);
                                  if (pressed == true && likes > 0) {
                                    likes = likes - 1;
                                  } else if (pressed != true && likes == 0) {
                                    // postMassage();
                                    likes = likes + 1;
                                  } else if (pressed != true && likes > 0) {
                                    likes = likes + 1;
                                  }
                                  likes = likes;
                                });
                                Api().postLikeConfirm(
                                    widget.id, pressed, currentUser.email!);
                                Api().like(widget.id, pressed);
                                //postLikeToFirebase();
                              },
                              icon: pressed == true
                                  ? Icon(Icons.thumb_up_outlined)
                                  : Icon(Icons.thumb_up)),
                          Text(likes.toString()),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Comment(
                                            widget.id, widget.profile)));
                              },
                              icon: Icon(Icons.comment_outlined)),
                          user == currentUser.email
                              ? IconButton(
                                  onPressed: () async {
                                    await Api()
                                        .deletePost(widget.id)
                                        .whenComplete(() {
                                      setState(() {});
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => Center(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Navbar()));
                                                    },
                                                    child: Container(
                                                      color: Colors.white,
                                                      width: 225,
                                                      height: 75,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Center(
                                                          child: Text(
                                                              "Post dihapus",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ),
                                                      ),
                                                    )),
                                              ));
                                      setState(() {});
                                    });
                                  },
                                  icon: Icon(Icons.delete_outlined))
                              : Container()
                        ],
                      ),
                      Text(widget.msg),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
