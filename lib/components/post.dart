import 'package:flutter/material.dart';
import 'package:b_social02/pages/PostProfile.dart';

class FetchPost extends StatefulWidget {
  final String username;
  final String msg;
  final String img;
  final String like;
  final String email;

  const FetchPost(this.username, this.msg, this.img, this.like, this.email);

  @override
  State<FetchPost> createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {
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
                  Icon(Icons.people),
                  Padding(padding: EdgeInsets.all(15)),
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
                              onPressed: () {}, icon: Icon(Icons.thumb_up)),
                          Text(widget.like)
                        ],
                      ),
                      Text(widget.msg),
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
