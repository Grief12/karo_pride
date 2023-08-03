import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  final String url = 'http://127.0.0.1:8000/api/post';

  Future getPost() async {
    final result = await http.get(Uri.parse(url));

    Map<String, dynamic> map = json.decode(result.body);
    return map;
  }
}
