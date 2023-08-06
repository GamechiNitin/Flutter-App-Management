part of 'app_bloc.dart';

@immutable
class AppState {
  final bool isLoading;
  final String? data;
  final String? error;

  const AppState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  const AppState.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error,
      }.toString();
}

// class AppInitial extends AppState {
//   AppInitial({
//     required super.isLoading,
//     required super.data,
//     required super.error,
//   });
// }
