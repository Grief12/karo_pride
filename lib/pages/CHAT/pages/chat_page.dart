import 'dart:io';
import 'package:b_social02/Api.dart';
import 'package:b_social02/components/bubblechat.dart';
import 'package:b_social02/components/bublechat2.dart';
import 'package:b_social02/components/textfield.dart';
import 'package:b_social02/pages/CHAT/service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverUid;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverUid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Api api = Api();
  final currentUser = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;
  String? imgUrl;
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty && pickedFile == null) {
      await _chatService.sendMessages(
        widget.receiverUid,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  void insertphoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });

      print(pickedFile!.name);
    } else {
      // User canceled the picker
      setState(() {
        pickedFile = null;
      });
    }
  }

  Future upFoto() async {
    File file = File(pickedFile!.path!);
    String filename = pickedFile!.name;
    String ext = pickedFile!.extension!;
    final ref = firebase_storage.FirebaseStorage.instance.ref('$filename.$ext');
    final up = ref.putFile(file);

    final snapshot = await up.whenComplete(() {});

    final urlImg = await snapshot.ref.getDownloadURL();

    try {
      snapshot;
      urlImg;
      imgUrl = urlImg;
    } on firebase_storage.FirebaseStorage catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.receiverEmail,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //messages
          Expanded(
            child: _buildMessageList(),
          ),
          //input
          _buildMessageInput(),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  //list message
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUid, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? ChatBubble2(message: data['message'])
                : ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  //input
  Widget _buildMessageInput() {
    return Row(
      children: [
        const SizedBox(width: 8),
        //textfielf
        Expanded(
            child: MyTextField(
          controller: _messageController,
          hintText: 'Pesan..',
          obscureText: false,
        )),

        //button
        IconButton(
            onPressed: insertphoto,
            icon: const Icon(
              Icons.image,
              size: 30,
            )),
        IconButton(
          padding: const EdgeInsets.all(10.0),
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 30,
          ),
        )
      ],
    );
  }
}
