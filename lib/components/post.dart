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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.people),
                Padding(padding: EdgeInsets.all(15)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        widget.img,
                        fit: BoxFit.contain,
                      ),
                    ),
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
