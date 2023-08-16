import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  final String urlPost = 'http://192.168.100.19:8000/api/post';
  final String urlUser = 'http://192.168.100.19:8000/api/user';
  final String urlChat = 'http://192.168.100.19:8000/api/chat';
  final String urlProfil = 'http://192.168.100.19:8000/api/profil';

  Future getPost() async {
    final result = await http.get(Uri.parse(urlPost));

    return json.decode(result.body);
  }

  Future fetchUser() async {
    final result = await http.get(Uri.parse(urlUser));

    return json.decode(result.body);
  }

  Future post(String user, String msg, int like) async {
    final result = await http.post(Uri.parse("http://127.0.0.1:8000/api/post"),
        body: {"username": user, "message": msg, "likes": like.toString()});
    return json.decode(result.body);
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
