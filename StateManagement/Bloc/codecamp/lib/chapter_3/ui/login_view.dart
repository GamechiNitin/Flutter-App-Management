import 'package:codecamp/chapter_3/data/strings.dart';
import 'package:codecamp/chapter_3/ui/widget/login_button.dart';
import 'package:codecamp/utils/widget/text_field/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LogInView extends HookWidget {
  const LogInView({required this.logInTapped, super.key});
  final LogInTapped logInTapped;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          TextFieldWidget(
            controller: emailController,
            hintText: enterYourEmailHere,
          ),
          TextFieldWidget(
            controller: passwordController,
            hintText: enterYourPasswordHere,
            obsecure: false,
          ),
          LogInButton(
            emailController: emailController,
            passwordController: passwordController,
            logInTapped: logInTapped,
          ),
        ],
      ),
    );
  }
}
