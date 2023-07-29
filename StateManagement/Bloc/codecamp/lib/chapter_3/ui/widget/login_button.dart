import 'package:codecamp/chapter_3/data/strings.dart';
import 'package:codecamp/utils/widget/generic_dialog.dart';
import 'package:flutter/material.dart';

typedef LogInTapped = void Function(String email, String password);

class LogInButton extends StatelessWidget {
  const LogInButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.logInTapped,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LogInTapped logInTapped;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;
        if (email.isEmpty || password.isEmpty) {
          showGenericDialog<bool>(
            context: context,
            title: emailEmpty,
            content: emailPasswordDesc,
            optionsBuilder: () => {
              ok: true,
            },
          );
        } else {
          logInTapped(email, password);
        }
      },
      child: const Text("LogIn"),
    );
  }
}
