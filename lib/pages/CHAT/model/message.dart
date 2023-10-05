import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final String? imgUrl;
  final Timestamp timestamp;

  Messages({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    if (imgUrl != null) {
      return {
        'senderId': senderId,
        'senderEmail': senderEmail,
        'receiverId': receiverId,
        'message': imgUrl,
        'timestamp': timestamp,
      };
    } else {
      return {
        'senderId': senderId,
        'senderEmail': senderEmail,
        'receiverId': receiverId,
        'message': message,
        'timestamp': timestamp,
      };
    }
  }
}
