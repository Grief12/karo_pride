import 'package:b_social02/Api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:b_social02/pages/Comment.dart';
import 'package:b_social02/pages/PostProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//import 'package:b_social02/components/like_button.dart';

class FetchPost extends StatefulWidget {
  final int id;
  final String username;
  final String msg;
  final String img;
  final int like;
  final String email;
  final List arrLikes;
  const FetchPost(this.id, this.username, this.msg, this.img, this.like,
      this.email, this.arrLikes);

  @override
  State<FetchPost> createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {
  late int likes = widget.like;
  late int posId = widget.id;
  String tes = "maklor@gmail.com";
  //late final confirm = loopment();
  final currentUser = FirebaseAuth.instance.currentUser!;
  late final jsonData = Api().fetchLike(widget.id);
  TextEditingController commentCotroller = TextEditingController();
  bool pressed = true;
  int arrLengthh = 0;
  var arrData;
  //late bool confirms = widget.confirm == 0 ? false : true;

  // void postLikeToFirebase() {
  //   DocumentReference postRef = FirebaseFirestore.instance
  //       .collection('Likes')
  //       .doc(widget.id.toString());

  //   if (pressed) {
  //     postRef.update({
  //       'Likes': FieldValue.arrayUnion([currentUser.email])
  //     });
  //   } else {
  //     postRef.update({
  //       'Likes': FieldValue.arrayRemove([currentUser.email])
  //     });
  //   }
  // }

  void postMassage() async {
    var doc = FirebaseFirestore.instance
        .collection("Likes")
        .doc(widget.id.toString());
    doc.set({
      'Likes': [currentUser.email],
    });
  }

  searchData() {
    for (int i = 0; i < widget.arrLikes.length; i++) {
      if (widget.id == widget.arrLikes[i]['post_id']) {
        print(widget.arrLikes.length);
        return widget.arrLikes;
      }
    }
  }

  loopment(panjang) {
    for (int i = 0; i < panjang.length;) {
      if (widget.id == widget.arrLikes[i]['post_id']) {
        if (currentUser.email == widget.arrLikes[i]['email']) {
          setState(() {
            pressed = false;
          });
          return false;
        } else {
          setState(() {
            pressed = true;
          });
          return true;
        }
      } else {
        setState(() {
          pressed = true;
        });
        return true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    arrData = searchData();
    pressed = arrData.length == 0 ? true : loopment(arrData);
    arrLengthh = arrData.length;
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
                    height: 13,
                  ),
                  Icon(Icons.people),
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
                        child: Container(
                          width: 300,
                          height: 200,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(widget.img, fit: BoxFit.cover),
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
                                  if (pressed == true && arrLengthh > 0) {
                                    arrLengthh = arrLengthh - 1;
                                  } else if (pressed != true &&
                                      arrLengthh == 0) {
                                    postMassage();
                                    arrLengthh = arrLengthh + 1;
                                  } else if (pressed != true &&
                                      arrLengthh > 0) {
                                    arrLengthh = arrLengthh + 1;
                                  }
                                  arrLengthh = arrLengthh;
                                });
                                //Api().postLikeConfirm(widget.id,
                                //    pressed, currentUser.email!);
                                Api().like(widget.like, widget.id, pressed);
                                //postLikeToFirebase();
                              },
                              icon: pressed == true
                                  ? Icon(Icons.thumb_up_outlined)
                                  : Icon(Icons.thumb_up)),
                          Text(arrLengthh.toString()),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: Comment(widget.id),
                                  withNavBar: true,
                                );
                              },
                              icon: Icon(Icons.comment_outlined))
                        ],
                      ),
                      Text(widget.msg),
                      SizedBox(
                        height: 20,
                      ),
                      // Expanded(
                      //     child: TextFormField(
                      //   controller: commentCotroller,
                      //   minLines: 1,
                      //   maxLines: 90,
                      //   decoration: InputDecoration(hintText: "Keren"),
                      // ))
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
