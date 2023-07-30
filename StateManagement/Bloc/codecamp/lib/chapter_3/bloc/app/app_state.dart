part of 'app_bloc.dart';

@immutable
class AppState {
  final bool isLoading;
  final LogInError? logInError;
  final LogInHandle? logInHandle;
  final Iterable<Note>? fetchNotes;

  const AppState({
    this.isLoading = false,
    this.logInError,
    this.logInHandle,
    this.fetchNotes,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'logInError': logInError,
        'logInHandle': logInHandle,
        'fetchNotes': fetchNotes,
      }.toString();

  const AppState.empty()
      : isLoading = false,
        logInError = null,
        logInHandle = null,
        fetchNotes = null;

  @override
  bool operator ==(covariant AppState other) {
    final otherPropertiesAreEqual = isLoading == other.isLoading &&
        logInError == other.logInError &&
        logInHandle == other.logInHandle;

    if (fetchNotes == null && other.fetchNotes == null) {
      return otherPropertiesAreEqual;
    } else {
      return otherPropertiesAreEqual &&
          (fetchNotes?.isEqualTo(other.fetchNotes) ?? false);
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        logInError,
        logInHandle,
        fetchNotes,
      );
}

class AppInitialState implements AppState {
  final bool isLoadingInitial;
  final LogInError? logInErrorInitial;
  final LogInHandle? logInHandleInitial;
  final Iterable<Note>? fetchNotesInitial;

  const AppInitialState({
    this.isLoadingInitial = false,
    this.logInErrorInitial,
    this.logInHandleInitial,
    this.fetchNotesInitial,
  });

  @override
  Iterable<Note>? get fetchNotes => fetchNotesInitial;

  @override
  bool get isLoading => isLoadingInitial;

  @override
  LogInError? get logInError => logInErrorInitial;

  @override
  LogInHandle? get logInHandle => logInHandleInitial;
}

extension UnorderedEquality on Object {
  bool isEqualTo(other) =>
      const DeepCollectionEquality.unordered().equals(this, other);
}
