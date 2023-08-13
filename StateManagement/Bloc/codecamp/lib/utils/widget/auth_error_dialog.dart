import 'package:codecamp/chapter_5/utils/auth_error.dart';
import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showAuthErrorDialog({
  required BuildContext context,
  required AuthError authError,
}) =>
    showGenericDialogs<void>(
      context: context,
      title: authError.title,
      content: authError.message,
      optionsBuilder: () => {
        'Ok': true,
      },
    );
