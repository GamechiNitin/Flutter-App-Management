import 'package:codecamp/chapter_5/bloc/share_app_bloc.dart';
import 'package:codecamp/chapter_5/utils/debuggging.dart';
import 'package:codecamp/utils/widget/text_field/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LogInView extends HookWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'test@mail.com'.ifDebugging);
    final passwordController =
        useTextEditingController(text: 'Test@321'.ifDebugging);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFieldWidget(
              controller: emailController,
              hintText: 'Enter Your Email Here',
            ),
            TextFieldWidget(
              controller: passwordController,
              hintText: 'Enter Your Password Here',
              obsecure: false,
            ),
            TextButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                context.read<ShareAppBloc>().add(
                      LogInShareAppEvent(
                        email: email,
                        password: password,
                      ),
                    );
              },
              child: const Text('LogIn'),
            ),
            TextButton(
              onPressed: () {
                context.read<ShareAppBloc>().add(
                      const RegiterNavigateShareAppEvent(),
                    );
              },
              child: const Text('No Account? Register...'),
            ),
          ],
        ),
      ),
    );
  }
}
