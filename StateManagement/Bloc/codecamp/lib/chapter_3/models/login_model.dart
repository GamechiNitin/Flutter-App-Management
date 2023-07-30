import "package:flutter/foundation.dart" show immutable;

@immutable
class LogInHandle {
  final String token;

  const LogInHandle({required this.token});

  const LogInHandle.fooBar() : token = 'token';

  @override
  bool operator ==(covariant LogInHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LogInHandle (token = $token)';
}
