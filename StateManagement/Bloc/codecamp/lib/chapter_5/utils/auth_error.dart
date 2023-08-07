import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

Map<String, AuthError> authErrorMapping = {
  'user-not-found': const UserNotFoundAuthError(), // auth/user-not-found
  'weak-password': const WeakPasswordAuthError(), // auth/weak-password
  'invalid-email': const InvalidEmailAuthError(), // auth/invalid-email
  'operation-not-allowed':
      const OperationNotAllowedAuthError(), // auth/operation-not-allowed
  'email-already-in-use':
      const UsedEmailAuthError(), // auth/email-already-in-use
  'requires-recent-login':
      const RequireRecentLogInAuthError(), // auth/requires-recent-login
  'no-current-user': const NoUserAuthError(), // auth/no-current-user
};

@immutable
abstract class AuthError {
  final String title;
  final String message;

  const AuthError({
    required this.title,
    required this.message,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      AuthErrorUnknown(exception);
}

@immutable
class AuthErrorUnknown extends AuthError {
  final FirebaseAuthException innerexception;
  const AuthErrorUnknown(this.innerexception)
      : super(
          title: 'Authentication error',
          message: 'Unknown Authentication error',
        );
}

@immutable
class NoUserAuthError extends AuthError {
  const NoUserAuthError()
      : super(
          title: 'No current user!',
          message: 'No current user with this information was found',
        );
}

@immutable
class RequireRecentLogInAuthError extends AuthError {
  const RequireRecentLogInAuthError()
      : super(
          title: 'Require recent login',
          message:
              'You need to Logout and LogIn back in order to perform this operation',
        );
}

// Service not Enable
@immutable
class OperationNotAllowedAuthError extends AuthError {
  const OperationNotAllowedAuthError()
      : super(
          title: 'Operation not allowed',
          message:
              'You can not register using this method at this moment time!',
        );
}

// Service not Enable
// auth/user-not-found
@immutable
class UserNotFoundAuthError extends AuthError {
  const UserNotFoundAuthError()
      : super(
          title: 'User not found',
          message: 'The given user was not found on the server!',
        );
}

@immutable
class WeakPasswordAuthError extends AuthError {
  const WeakPasswordAuthError()
      : super(
          title: 'Weak password',
          message:
              'Please choose a stronger password consisting of more characters',
        );
}

@immutable
class InvalidEmailAuthError extends AuthError {
  const InvalidEmailAuthError()
      : super(
          title: 'Invalid Email',
          message: 'Please double check your email and try again!',
        );
}

@immutable
class UsedEmailAuthError extends AuthError {
  const UsedEmailAuthError()
      : super(
          title: 'Email already in use',
          message: 'Please choose another email to register with!',
        );
}
