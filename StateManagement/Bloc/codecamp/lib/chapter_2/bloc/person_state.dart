part of 'person_bloc.dart';

@immutable
class FetchResultState {
  final Iterable<Person> person;
  final bool isRetrivedFromCached;

  const FetchResultState({
    required this.person,
    required this.isRetrivedFromCached,
  });

  @override
  String toString() =>
      'FetchResult (isRetrivedFromCached = $isRetrivedFromCached, person = $person)';
}
