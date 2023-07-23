part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LogInAction implements AppEvent {
  final String email, password;

  const LogInAction({
    required this.email,
    required this.password,
  });
}

@immutable
class LoadNotesEvent implements AppEvent {
  const LoadNotesEvent();
}
