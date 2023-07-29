import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingController({
    required this.close,
    required this.update,
  });
}
