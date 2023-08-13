import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialogs<bool>(
      context: context,
      title: 'Delete account',
      content:
          'Are you sure you want to delete your account? You cannot undo this operation',
      optionsBuilder: () => {
            'Cancel': false,
            'Delete account': true,
          }).then(
    (value) => value ?? false,
  );
}
