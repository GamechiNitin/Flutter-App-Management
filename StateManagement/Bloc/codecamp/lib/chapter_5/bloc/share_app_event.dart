part of 'share_app_bloc.dart';

@immutable
abstract class ShareAppEvent {
  const ShareAppEvent();
}

@immutable
class UploadImageShareAppEvent implements ShareAppEvent {
  final String filePath;

  const UploadImageShareAppEvent(this.filePath);
}

@immutable
class DeleteAccountShareAppEvent implements ShareAppEvent {
  const DeleteAccountShareAppEvent();
}

@immutable
class LogOutShareAppEvent implements ShareAppEvent {
  const LogOutShareAppEvent();
}

@immutable
class InitilizeShareAppEvent implements ShareAppEvent {
  const InitilizeShareAppEvent();
}

@immutable
class LogInShareAppEvent implements ShareAppEvent {
  final String email;
  final String password;

  const LogInShareAppEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class RegisterShareAppEvent implements ShareAppEvent {
  final String email;
  final String password;

  const RegisterShareAppEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class RegiterNavigateShareAppEvent implements ShareAppEvent {
  const RegiterNavigateShareAppEvent();
}

@immutable
class LogInNavigateShareAppEvent implements ShareAppEvent {
  const LogInNavigateShareAppEvent();
}
