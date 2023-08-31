import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  final String urlPost = 'http://api-punya-farrdan.000webhostapp.com/api/post';
  final String urlUser = 'http://api-punya-farrdan.000webhostapp.com/api/user';
  final String urlChat = 'http://api-punya-farrdan.000webhostapp.com/api/chat';
  final String urlProfil =
      'http://api-punya-farrdan.000webhostapp.com/api/profil';

  Future getPost() async {
    final result = await http.get(Uri.parse(urlPost));

    return json.decode(result.body);
  }

  Future fetchUser() async {
    final result = await http.get(Uri.parse(urlUser));

    return json.decode(result.body);
  }

  Future post(String user, String? msg, like, [var img = null]) async {
    if (img != null) {
      final res = await http.post(Uri.parse(urlPost), body: {
        "username": user,
        "message": msg,
        "likes": like.toString(),
        "imgurl": img
      });

      return json.decode(res.body);
    } else {
      final result = await http.post(Uri.parse(urlPost),
          body: {"username": user, "message": msg, "likes": like.toString()});

      return json.decode(result.body);
    }
  }

  Future profile(String email) async {
    final result = await http.get(Uri.parse(urlProfil + '/${email}'));

    print(urlUser + '/${email}');
    return json.decode(result.body);
  }

  Future registerUser(
    String email,
    String username,
    String password,
  ) async {
    final result = await http.post(Uri.parse(urlUser), body: {
      "email": email,
      "username": username,
      "password": password,
    });
    return json.decode(result.body);
  }

  Future fetchChat(String email) async {
    final result = await http.get(Uri.parse(urlChat + '/${email}'));

    return json.decode(result.body);
  }
}
