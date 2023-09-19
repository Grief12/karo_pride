import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comment extends StatefulWidget {
  final int postId;
  const Comment(this.postId);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> refresh() {
    return api.fetchKomen(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: api.fetchKomen(widget.postId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                        child: ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (context, index) {
                            final komen = snapshot.data['data'][index];
                            return Container(
                              margin: EdgeInsets.all(15),
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.people),
                                      Padding(padding: EdgeInsets.all(10)),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [Text(komen['username'])],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [Text(komen['pesan'])],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                        onRefresh: refresh);
                  }
                  return Container();
                }),
            Row(children: [
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                    child: Row(
                  children: [
                    TextFormField(
                      minLines: 1,
                      maxLines: 15,
                      decoration: InputDecoration(hintText: "keren"),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.send))
                  ],
                )),
              )
            ])
          ],
        ));
  }
}
