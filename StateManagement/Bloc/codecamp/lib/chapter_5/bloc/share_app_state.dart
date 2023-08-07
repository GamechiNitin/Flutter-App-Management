part of 'share_app_bloc.dart';

@immutable
abstract class ShareAppState {
  final bool isLoading;
  final AuthError? authError;

  const ShareAppState({
    this.isLoading = false,
    this.authError,
  });
}

@immutable
class LoggedInShareAppState extends ShareAppState {
  final User user;
  final Iterable<Reference> images;
  const LoggedInShareAppState({
    required this.user,
    required this.images,
    required bool isLoading,
    required AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );

  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is LoggedInShareAppState) {
      return isLoading == otherClass.isLoading &&
          user.uid == otherClass.user.uid &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        images,
      );

  @override
  String toString() =>
      'LoggedInShareAppState, images.length = ${images.length}';
}

@immutable
class LogOutState extends AppState {
  const LogOutState({
    required bool isLoading,
    required AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}

@immutable
class RegisterShareAppState extends AppState {
  const RegisterShareAppState({
    required bool isLoading,
    required AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}
