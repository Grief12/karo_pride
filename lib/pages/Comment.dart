import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comment extends StatefulWidget {
  final int postId;
  final profile;
  const Comment(this.postId, this.profile);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;
  TextEditingController commentCotroller = TextEditingController();

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
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.white,
                  barrierColor: Color(0x2e000000),
                  context: context,
                  builder: (context) => Container(
                      height: 200,
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            minLines: 1,
                            maxLines: 9,
                            controller: commentCotroller,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              hintText: 'Enter text',
                            ),
                          )),
                          IconButton(
                              onPressed: () async {
                                await Api().postKomen(commentCotroller.text,
                                    widget.postId, currentUser.email!);
                                commentCotroller.clear();
                                setState(() {});
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.send))
                        ],
                      )));
            },
            child: Center(child: Icon(Icons.comment))),
        body: Column(
          children: [
            FutureBuilder(
                future: api.fetchKomen(widget.postId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                        child: ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
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
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
          ],
        ));
  }
}
