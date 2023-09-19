import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final onTap;
  final isLike;
  const LikeButton(this.onTap, this.isLike);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: widget.isLike == true
            ? Icon(Icons.thumb_up_outlined)
            : Icon(Icons.thumb_up));
  }
}

// LikeButton(() {
//                             setState(() {
//                               jsonData.then((value) {
//                                 print(value['data'][0]['confirm']);
//                                 print("ini value");
//                               });
//                               print(pressed);
//                               return;
//                               pressed = !pressed;
//                               print(pressed);
//                               if (pressed == true && likes > 0) {
//                                 likes = likes - 1;
//                               } else if (pressed != true && likes == 0) {
//                                 postMassage();
//                                 likes = likes + 1;
//                               } else if (pressed != true && likes > 0) {
//                                 likes = likes + 1;
//                               }
//                               likes = likes;
//                             });
//                             //Api().postLikeConfirm(widget.id,
//                             //    pressed, currentUser.email!);
//                             Api().like(widget.like, widget.id, pressed);
//                             //postLikeToFirebase();
//                           },
//                           isLike),
