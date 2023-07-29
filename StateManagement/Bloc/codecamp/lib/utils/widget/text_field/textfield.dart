import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool? obsecure;
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.obsecure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obsecure ?? false,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
