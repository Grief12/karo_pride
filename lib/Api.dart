import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  final String urlPost = 'http://192.168.100.19:8000/api/post';

  Future getPost() async {
    final result = await http.get(Uri.parse(urlPost));

    Map<String, dynamic> map = json.decode(result.body);
    return map;
  }

  Future post(String user, String msg, int like) async {
    final result = await http.post(
        Uri.parse("http://192.168.100.19:8000/api/post"),
        body: {"username": user, "message": msg, "likes": like.toString()});
    return json.decode(result.body);
  }
}
