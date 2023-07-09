import 'dart:async';
import 'dart:developer';

import 'package:codecamp/chapter_2/helper.dart';
import 'package:codecamp/chapter_2/model/person.dart';
import 'package:codecamp/chapter_2/repo/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, FetchResultState?> {
  // For Caching
  final Map<PersonUrl, Iterable<Person>> _cache = {};

  PersonBloc() : super(null) {
    on<PersonActionEvent>(loadPersonActionEvent);
  }

  FutureOr<void> loadPersonActionEvent(
      PersonActionEvent event, Emitter<FetchResultState?> emit) async {
    log("here");
    final url = event.url;
    if (_cache.containsKey(url)) {
      // Already Cached
      final cachedPerson = _cache[url];
      final result = FetchResultState(
        person: cachedPerson!,
        isRetrivedFromCached: true,
      );
      emit(result);
    } else {
      final persons = await getLocalPerson(url.urlString);
      _cache[url] = persons;
      final result = FetchResultState(
        person: persons,
        isRetrivedFromCached: false,
      );
      emit(result);
    }
  }
}
