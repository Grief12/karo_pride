import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Like extends StatefulWidget {
  final int postId;
  const Like(this.postId);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
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
          title: Text("Like"),
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: api.fetchLike(widget.postId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                        child: ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final like = snapshot.data['data'][index];
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
                                          child: like['profile'] == null
                                              ? Icon(
                                                  Icons.person,
                                                  size: 25,
                                                )
                                              : Image.network(
                                                  like['profile'],
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
                                            children: [Text(like['username'])],
                                          ),
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
                })
          ],
        ));
  }
}
