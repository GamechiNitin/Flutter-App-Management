import 'dart:async';

import 'package:codecamp/chapter_3/api/login_api.dart';
import 'package:codecamp/chapter_3/api/notes_api.dart';
import 'package:codecamp/chapter_3/data/mock_data.dart';
import 'package:codecamp/chapter_3/models/login_model.dart';
import 'package:codecamp/chapter_3/models/note_model.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LogInApiProtocol logInApiProtocol;
  final NotesApiProtocol notesApiProtocol;
  AppBloc({
    required this.logInApiProtocol,
    required this.notesApiProtocol,
  }) : super(const AppInitialState()) {
    on<LogInAction>(logInAction);
    on<LoadNotesEvent>(loadNotesEvent);
  }

  FutureOr<void> logInAction(LogInAction event, Emitter<AppState> emit) async {
    // Loading
    emit(const AppInitialState(isLoadingInitial: true));

    // LogInAPI
    final logInHandle = await logInApiProtocol.logIn(
      email: event.email,
      password: event.password,
    );

    emit(
      AppInitialState(
        logInHandleInitial: logInHandle,
        logInErrorInitial:
            logInHandle == null ? LogInError.invalidHandle : null,
      ),
    );
  }

  FutureOr<void> loadNotesEvent(
      LoadNotesEvent event, Emitter<AppState> emit) async {
    // Loading
    emit(AppInitialState(
      isLoadingInitial: true,
      logInHandleInitial: state.logInHandle,
    ));

    // Notes API
    final logInHandle = state.logInHandle;
    if (logInHandle != const LogInHandle.fooBar()) {
      // invalid LoginHandle, cannot fetch notes
      emit(
        AppInitialState(
          isLoadingInitial: false,
          logInErrorInitial: LogInError.invalidHandle,
          logInHandleInitial: logInHandle,
        ),
      );
    } else {
      // This is valid Login Handle

      final notes = await notesApiProtocol.getNotes(
        logInHandle: logInHandle!,
      );
      emit(
        AppInitialState(
          isLoadingInitial: false,
          logInHandleInitial: logInHandle,
          fetchNotesInitial: notes,
          logInErrorInitial: null,
        ),
      );
    }
  }
}
