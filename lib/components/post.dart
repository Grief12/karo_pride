import 'package:b_social02/Api.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/pages/Comment.dart';
import 'package:b_social02/pages/PostProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:b_social02/components/like_button.dart';
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
  var arrData;
  late List likearrConf = widget.arrLikes
      .where((element) => element['post_id'] == widget.id)
      .toList();
  bool pressed = true;

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
    pressed = arrData == currentUser.email ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        // padding: EdgeInsets.only(top: 7),
        width: 500,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                    child: Container(
                                      child: Image.network(
                                        widget.img,
                                        fit: BoxFit.fill,
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
                                        builder: (context) =>
                                            Comment(widget.id)));
                              },
                              icon: Icon(Icons.comment_outlined))
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
