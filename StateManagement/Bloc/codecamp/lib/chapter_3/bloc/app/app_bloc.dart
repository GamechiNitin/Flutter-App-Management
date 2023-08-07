import 'dart:async';
import 'dart:developer';

import 'package:codecamp/chapter_3/api/login_api.dart';
import 'package:codecamp/chapter_3/api/notes_api.dart';
import 'package:codecamp/chapter_3/data/mock_data.dart';
import 'package:codecamp/chapter_3/models/login_model.dart';
import 'package:codecamp/chapter_3/models/note_model.dart';
import 'package:codecamp/chapter_5/utils/auth_error.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LogInApiProtocol logInApi;
  final NotesApiProtocol notesApi;
  final LogInHandle acceptedLogInHandle;

  AppBloc({
    required this.logInApi,
    required this.notesApi,
    required this.acceptedLogInHandle,
  }) : super(const AppInitialState()) {
    on<LogInAction>(logInAction);
    on<LoadNotesEvent>(loadNotesEvent);
  }

  FutureOr<void> logInAction(LogInAction event, Emitter<AppState> emit) async {
    // Loading
    emit(const AppInitialState(isLoadingInitial: true));

    // LogInAPI
    final logInHandle = await logInApi.logIn(
      email: event.email,
      password: event.password,
    );

    log("Token ${logInHandle?.token}");
    if (logInHandle == const LogInHandle.fooBar()) {
      emit(const AppInitialState(logInHandleInitial: LogInHandle.fooBar()));
    } else {
      emit(const AppInitialState(logInErrorInitial: LogInError.invalidHandle));
    }
  }

  FutureOr<void> loadNotesEvent(
      LoadNotesEvent event, Emitter<AppState> emit) async {
    // Loading
    emit(
      const AppInitialState(
        isLoadingInitial: true,
        logInHandleInitial: LogInHandle.fooBar(),
      ),
    );

    // Notes API
    final logInHandle = state.logInHandle;
    if (logInHandle != acceptedLogInHandle) {
      // invalid LoginHandle, cannot fetch notes
      emit(
        const AppInitialState(
          isLoadingInitial: false,
          logInErrorInitial: LogInError.invalidHandle,
        ),
      );
    } else {
      // This is valid Login Handle

      final notes = await notesApi.getNotes(logInHandle: logInHandle!);
      if (notes != null) {
        emit(
          const AppInitialState(
            isLoadingInitial: false,
            logInHandleInitial: LogInHandle.fooBar(),
            fetchNotesInitial: [
              Note(title: 'Note 1'),
              Note(title: 'Note 2'),
              Note(title: 'Note 3'),
            ],
            logInErrorInitial: null,
          ),
        );
      }
    }
  }
}
