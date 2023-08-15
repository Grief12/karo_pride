import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final ref =
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
            //stream: ref.child(SessionController().UserId.toString()).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
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
                          child: map['profile'].toString() == ""
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
                      title: 'userName',
                      value: map['username'],
                      iconData: Icons.person_outline,
                    ),
                    dannrow(
                      title: 'Bio',
                      value: map['bio'] == '' ? '' : map['phone'],
                      iconData: Icons.person_outlined,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    'someting went wrong',
                    style: Theme.of(context).textTheme.subtitle1,
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
