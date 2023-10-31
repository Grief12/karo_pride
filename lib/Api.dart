import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:b_social02/auth/Token.dart';

class Api {
  final String urlPost = 'http://127.0.0.1:8000/api/post';
  final String urlUser = 'http://127.0.0.1:8000/api/user';
  final String urlChat = 'http://127.0.0.1:8000/api/chat';
  final String urlProfil = 'http://127.0.0.1:8000/api/profil';
  final String urlKomen = 'http://127.0.0.1:8000/api/komen';

  Token token = Token();

  Future getPost() async {
    final result = await http.get(Uri.parse(urlPost));

    return json.decode(result.body);
  }

  Future getMyPost(String email) async {
    final result = await http.get(Uri.parse(urlPost + '/${email}'));

    return json.decode(result.body);
  }

  Future like(id, bool pressed) async {
    print("id post ke ${id}");
    int confirm = pressed == false ? 0 : 1;
    int like = 1;

    print("like post ke ${like}");
    final result = await http.post(Uri.parse(urlPost + '/like/${id}'), body: {
      "likes": like.toString(),
      "pressed": confirm.toString(),
      "token": token.getToken()
    });

    print(json.decode(result.body));
    return json.decode(result.body);
  }

  Future fetchLike(id) async {
    final result = await http.get(Uri.parse(urlPost + '/like/${id}'));
    return json.decode(result.body);
  }

  Future postLikeConfirm(id, bool pressed, email) async {
    int confirm = pressed == false ? 0 : 1;
    if (confirm == 0) {
      final result = await http.post(
          Uri.parse(urlPost + '/like/${id}/${email}'),
          body: {"confirm": confirm.toString(), "token": token.getToken()});
      print("data berhasil dipost");
      return json.decode(result.body);
    }
    if (confirm == 1) {
      final result = await http.delete(
          Uri.parse(urlPost + '/like/${id}/${email}'),
          body: {"confirm": confirm.toString(), "token": token.getToken()});
      print("data berhasil dipost");
      return json.decode(result.body);
    }
  }

  Future deletePost(int id) async {
    print("delte");
    final res = await http.delete(Uri.parse(urlPost),
        body: {"id": id.toString(), "token": token.getToken()});
    print(json.decode(res.body));
    return json.decode(res.body);
  }

  Future post(String user, String? msg, like, [var img = null]) async {
    if (img != null) {
      final res = await http.post(Uri.parse(urlPost), body: {
        "username": user,
        "message": msg,
        "likes": like.toString(),
        "imgurl": img,
        "token": token.getToken()
      });

      return json.decode(res.body);
    } else {
      final result = await http.post(Uri.parse(urlPost), body: {
        "username": user,
        "message": msg,
        "likes": like.toString(),
        "token": token.getToken()
      });

      return json.decode(result.body);
    }
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
    final result = await http.put(Uri.parse(urlProfil + '/${email}'),
        body: {"profile": url.toString()});
    return json.decode(result.body);
  }

  Future registerUser(
    String email,
    String username,
    String password,
  ) async {
    print("waiting");
    print(email);
    print(username);
    print(password);
    final result = await http.post(Uri.parse(urlUser), body: {
      "email": email,
      "username": username,
      "password": password,
      "bio": "Halo",
      "token": token.getToken()
    });
    print("berhasil di pos");
    return json.decode(result.body);
  }

  Future fetchChat(String email) async {
    final result = await http.get(Uri.parse(urlChat + '/${email}'));

    return json.decode(result.body);
  }

  Future fetchKomen(int id) async {
    final result = await http.get(Uri.parse(urlKomen + '/${id}'));
    return json.decode(result.body);
  }

  Future postKomen(String pesan, int id, String email) async {
    print("berhasil");
    print(id);
    final result = await http.post(Uri.parse(urlKomen + '/${id}'),
        body: {"pesan": pesan, "email": email, "token": token.getToken()});
    print("berhasil di post");
    return json.decode(result.body);
  }

  Future postChat(
    String user,
    String? msg,
    int penerima,
  ) async {
    print("pesan tidak boleh kosong");
    print(user);
    print(msg);
    print(penerima);
    if (msg != null) {
      final res = await http.post(Uri.parse(urlChat + '/${user}'), body: {
        "email": user,
        "pesan": msg,
        "receiverid": penerima.toString(),
      });

      return json.decode(res.body);
    }
  }

  Future getChat(email) async {
    final result = await http.get(Uri.parse(urlChat + '/${email}'));

    return json.decode(result.body);
  }
}
