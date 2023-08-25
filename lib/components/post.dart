import 'package:flutter/material.dart';

class FetchPost extends StatefulWidget {
  final String username;
  final String msg;
  final String img;

  const FetchPost(this.username, this.msg, this.img);

  @override
  State<FetchPost> createState() => _FetchPostState();
}

class _FetchPostState extends State<FetchPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.people),
                Column(
                  children: [
                    Text(widget.username),
                    SizedBox(
                      height: 10,
                    ),
                    Image.network(widget.img, height: 200, width: 200),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.msg),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
  }
}
