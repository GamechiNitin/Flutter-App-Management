// Error Enum
import 'package:codecamp/chapter_3/models/note_model.dart';

// Error Enum
enum LogInError { invalidHandle }

// Mock Notes
final mockNotes = Iterable.generate(
  3,
  (i) => Note(title: 'Note ${i + 1}'),
);
