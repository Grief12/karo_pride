import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  final String urlPost = 'http://192.168.100.20:8000/api/post';
  final String urlUser = 'http://192.168.100.20:8000/api/user';
  final String urlChat = 'http://192.168.100.20:8000/api/chat';
  final String urlProfil = 'http://192.168.100.20:8000/api/profil';

  Future getPost() async {
    final result = await http.get(Uri.parse(urlPost));

    return json.decode(result.body);
  }

  Future post(String user, String msg, int like) async {
    final result = await http.post(
        Uri.parse("http://192.168.100.19:8000/api/post"),
        body: {"username": user, "message": msg, "likes": like.toString()});
    return json.decode(result.body);
  }

  Future profile(String email) async {
    final result = await http.get(Uri.parse(urlProfil + '/${email}'));

    print(urlUser + '/${email}');
    return json.decode(result.body);
  }

  Future updateusernames(String username, String email) async {
    final result = await http.put(Uri.parse(urlProfil + '/${email}'),
        body: {"username": username.toString()});
    return json.decode(result.body);
  }

  Future updatebio(String bio, String email) async {
    final result = await http
        .put(Uri.parse(urlProfil + '/${email}'), body: {"bio": bio.toString()});
    return json.decode(result.body);
  }

  Future updatepp(String url, String email) async {
    final result = await http
        .put(Uri.parse(urlProfil + '/${email}'), body: {"url": url.toString()});
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

  Future fetchChat() async {
    final result = await http.get(Uri.parse(urlChat));

    return json.decode(result.body);
  }

  void updateusername(String s, String text, int i) {}
}
