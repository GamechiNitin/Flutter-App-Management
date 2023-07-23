import 'package:codecamp/chapter_3/models/login_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LogInApiProtocol {
  const LogInApiProtocol();

  Future<LogInHandle?> logIn({
    required String email,
    required String password,
  });
}

@immutable
class LogInApi implements LogInApiProtocol {
  // To create Singleton
  const LogInApi._sharedInstance();
  static const LogInApi _shared = LogInApi._sharedInstance();
  factory LogInApi.insatance() => _shared;

  @override
  Future<LogInHandle?> logIn({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'test@gmail.com' && password == 'foobar',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LogInHandle.fooBar() : null,
      );
}
