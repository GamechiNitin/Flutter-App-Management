part of 'person_bloc.dart';

@immutable
abstract class PersonEvent {}

@immutable
class PersonActionEvent implements PersonEvent {
  final PersonUrl url;
  const PersonActionEvent({required this.url}) : super();
}
