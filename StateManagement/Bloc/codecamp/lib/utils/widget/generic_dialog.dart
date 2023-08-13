import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialogs<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final option = optionsBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),  
      actions: option.keys.map((e) {
        final value = option[e];
        return TextButton(
          onPressed: () {
            if (value != null) {
              Navigator.of(context).pop(value);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(e),
        );
      }).toList(),
    ),
  );
}
