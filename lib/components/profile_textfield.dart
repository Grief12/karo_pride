import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator? onValidator;
  final TextInputType keyBoardType;
  final String hintText;
  final bool obscureText;
  final bool enable, autoFocus;

  const ProfileTextField(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.onFiledSubmittedValue,
      this.onValidator,
      required this.keyBoardType,
      required this.hintText,
      required this.obscureText,
      this.enable = true,
      this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      onFieldSubmitted: onFiledSubmittedValue,
      keyboardType: keyBoardType,
      validator: onValidator,
      cursorColor: Colors.black,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(height: 0, fontSize: 19),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        enabled: enable,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
      ),
    );
  }
}
