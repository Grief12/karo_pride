import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';

class PostProfile extends StatefulWidget {
  final String email;
  const PostProfile(this.email);

  @override
  State<PostProfile> createState() => _PostProfileState();
}

class _PostProfileState extends State<PostProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
            future: api.profile(widget.email),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                api.profile(currentUser.email!).then((value) {
                  print(value);
                });
                Map<dynamic, dynamic> map = snapshot.data['data'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: map['profile'] == null
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                )
                              : Image(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(map['profile'].toString()),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, object, stack) {
                                    return Container(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    dannrow(
                      title: 'Email',
                      value: map['email'],
                      iconData: Icons.email_outlined,
                    ),
                    dannrow(
                      title: 'Username',
                      value: map['username'],
                      iconData: Icons.person_outline,
                    ),
                    dannrow(
                      title: 'Bio',
                      value: map['bio'],
                      iconData: Icons.edit_outlined,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Please wait')
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class dannrow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const dannrow(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: Icon(
            iconData,
            color: Colors.black,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        )
      ],
    );
  }
}
