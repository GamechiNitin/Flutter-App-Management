import 'package:codecamp/chapter_3/api/login_api.dart';
import 'package:codecamp/chapter_3/api/notes_api.dart';
import 'package:codecamp/chapter_3/bloc/app/app_bloc.dart';
import 'package:codecamp/chapter_3/data/mock_data.dart';
import 'package:codecamp/chapter_3/models/login_model.dart';
import 'package:codecamp/chapter_3/models/note_model.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

@immutable
class DummyNotesAPI implements NotesApiProtocol {
  final LogInHandle acceptedLogInHandle;
  final Iterable<Note>? notesToReturnForAcceptedLogInHandle;

  const DummyNotesAPI({
    required this.acceptedLogInHandle,
    required this.notesToReturnForAcceptedLogInHandle,
  });

// Initial State Empty
  const DummyNotesAPI.empty()
      : acceptedLogInHandle = const LogInHandle.fooBar(),
        notesToReturnForAcceptedLogInHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({
    required LogInHandle logInHandle,
  }) async {
    if (logInHandle == acceptedLogInHandle) {
      return notesToReturnForAcceptedLogInHandle;
    } else {
      return null;
    }
  }
}

@immutable
class DummyLoginAPI extends LogInApiProtocol {
  final String acceptedEmail, acceptedPassword;
  final LogInHandle retunLogInHandle;

  const DummyLoginAPI({
    required this.acceptedEmail,
    required this.acceptedPassword,
    required this.retunLogInHandle,
  });

  @override
  Future<LogInHandle?> logIn({
    required String email,
    required String password,
  }) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return retunLogInHandle;
    } else {
      return null;
    }
  }

  const DummyLoginAPI.empty()
      : acceptedEmail = '',
        acceptedPassword = '',
        retunLogInHandle = acceptedLogInHandle;
}

const acceptedLogInHandle = LogInHandle(token: 'token');

void main() async {
  blocTest<AppBloc, AppState>(
    'AppState : Initial Empty State',
    build: () => AppBloc(
      logInApi: const DummyLoginAPI.empty(),
      notesApi: const DummyNotesAPI.empty(),
      acceptedLogInHandle: acceptedLogInHandle,
    ),
    verify: (appState) => expect(
      appState.state,
      const AppState.empty(),
    ),
  );
  blocTest<AppBloc, AppState>(
    'AppState : Login Action State',
    build: () => AppBloc(
      logInApi: const DummyLoginAPI(
        acceptedEmail: 'test@gmail.com',
        acceptedPassword: 'foobar',
        retunLogInHandle: acceptedLogInHandle,
      ),
      notesApi: const DummyNotesAPI.empty(),
      acceptedLogInHandle: acceptedLogInHandle,
    ),
    act: (bloc) => bloc.add(
      const LogInAction(
        email: 'test@gmail.com',
        password: 'foobar',
      ),
    ),
    expect: () => [
      const AppInitialState(isLoadingInitial: true),
      const AppInitialState(logInHandleInitial: acceptedLogInHandle),
    ],
  );
  blocTest<AppBloc, AppState>(
    'AppState : Invalid Login Credential Check',
    build: () => AppBloc(
      logInApi: const DummyLoginAPI(
        acceptedEmail: 'test@gmail.com',
        acceptedPassword: 'foobar',
        retunLogInHandle: acceptedLogInHandle,
      ),
      notesApi: const DummyNotesAPI.empty(),
      acceptedLogInHandle: acceptedLogInHandle,
    ),
    act: (bloc) => bloc.add(
      const LogInAction(
        email: 'error@test.com',
        password: '1234',
      ),
    ),
    expect: () => [
      const AppInitialState(isLoadingInitial: true),
      const AppInitialState(logInErrorInitial: LogInError.invalidHandle),
    ],
  );

  blocTest<AppBloc, AppState>(
    'AppState : Load Notes',
    build: () => AppBloc(
      logInApi: const DummyLoginAPI(
        acceptedEmail: 'test@gmail.com',
        acceptedPassword: 'foobar',
        retunLogInHandle: acceptedLogInHandle,
      ),
      notesApi: const DummyNotesAPI(
        acceptedLogInHandle: acceptedLogInHandle,
        notesToReturnForAcceptedLogInHandle: mockNotes,
      ),
      acceptedLogInHandle: acceptedLogInHandle,
    ),
    act: (bloc) {
      bloc.add(const LogInAction(email: 'test@gmail.com', password: 'foobar'));
      bloc.add(const LoadNotesEvent());
    },
    expect: () => [
      const AppInitialState(isLoadingInitial: true),
      const AppInitialState(
        isLoadingInitial: false,
        logInHandleInitial: acceptedLogInHandle,
      ),
      const AppInitialState(
        isLoadingInitial: true,
        logInHandleInitial: acceptedLogInHandle,
      ),
      const AppInitialState(
        isLoadingInitial: false,
        logInHandleInitial: acceptedLogInHandle,
        fetchNotesInitial: mockNotes,
        logInErrorInitial: null,
      )
    ],
  );
}
