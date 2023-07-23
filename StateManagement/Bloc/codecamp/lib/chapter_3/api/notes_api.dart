import 'package:codecamp/chapter_3/data/mock_data.dart';
import 'package:codecamp/chapter_3/models/login_model.dart';
import 'package:codecamp/chapter_3/models/note_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes({
    required LogInHandle logInHandle,
  });
}

@immutable
class NoteApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LogInHandle logInHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => logInHandle == const LogInHandle.fooBar() ? mockNotes : null,
      );
}
