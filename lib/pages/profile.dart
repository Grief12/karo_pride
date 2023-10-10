import 'dart:io';

import 'package:b_social02/components/profile/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:b_social02/Api.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Api api = Api();

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("P R O F I L E"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: signout,
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder(
                  future: api.profile(currentUser.email!),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey,
                                        )),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: provider.image == null
                                            ? map['profile'] == null
                                                ? Icon(
                                                    Icons.person,
                                                    size: 40,
                                                  )
                                                : Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        map['profile']),
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    errorBuilder: (context,
                                                        object, stack) {
                                                      return Container(
                                                        child: Icon(
                                                          Icons.error_outline,
                                                          color: Colors.black,
                                                        ),
                                                      );
                                                    },
                                                  )
                                            : Stack(
                                                children: [
                                                  Image.file(
                                                      File(provider.image!.path)
                                                          .absolute),
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                ],
                                              )),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  provider.pickImage(context);
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.add,
                                      size: 18, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            child: dannrow(
                              title: 'Email',
                              value: map['email'],
                              iconData: Icons.email_outlined,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.showUserNameDialogAlert(
                                  context, map['username']);
                            },
                            child: dannrow(
                              title: 'Username',
                              value: map['username'],
                              iconData: Icons.person_outline,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.showbioDialogAlert(context, map['bio']);
                            },
                            child: dannrow(
                              title: 'Bio',
                              value: map['bio'],
                              iconData: Icons.person_outlined,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: Container(
                                            width: 300,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 30),
                                                Text(
                                                    "Apakah anda ingin keluar?"),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          signout();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )));
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "L O G O U T",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
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
            );
          },
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
            style: TextStyle(color: Colors.grey[500]),
          ),
          leading: Icon(
            iconData,
            color: Colors.grey[500],
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
