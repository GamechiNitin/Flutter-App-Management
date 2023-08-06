import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'dart:math' as math;
part 'app_event.dart';
part 'app_state.dart';

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc extends Bloc<AppEvent, AppState> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc({
    required Iterable<String> urls,
    Duration? waitbeforeLoading,
    AppBlocRandomUrlPicker? urlPicker,
  }) : super(const AppState.empty()) {
    on<LoadNextUrlEvent>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          data: null,
          error: null,
        ),
      );

      final url = (urlPicker ?? _pickRandomUrl)(urls);

      try {
        if (waitbeforeLoading != null) {
          await Future.delayed(waitbeforeLoading);
        }

        emit(
          AppState(
            isLoading: false,
            data: url,
            error: null,
          ),
        );
      } catch (e) {
        log(e.toString());
        emit(
          AppState(
            isLoading: true,
            data: null,
            error: e.toString(),
          ),
        );
      }
    });
  }
}
