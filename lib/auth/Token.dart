import 'package:firebase_auth/firebase_auth.dart';

class Token {
  final currentUser = FirebaseAuth.instance.currentUser!;

  getToken(String email) {
    if (email == currentUser.email) {
      return "qIBv8lsFHTFMC4H1HzqQD5KS3zSdrZ8oo00E2FGA";
    } else {
      return 0;
    }
  }
}
