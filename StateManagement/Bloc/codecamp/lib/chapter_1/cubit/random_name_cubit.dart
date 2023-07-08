import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math show Random;

class RandomNameCubit extends Cubit<String?> {
  RandomNameCubit() : super(null);

  void pickRandomName() => emit(names.getRandomElement());
}

const names = ["Foo", "Bar", "Baz"];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}
