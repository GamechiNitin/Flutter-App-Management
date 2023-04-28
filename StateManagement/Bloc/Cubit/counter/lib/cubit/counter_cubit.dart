import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterInitial> {
  CounterCubit() : super(CounterInitial(countValue: 0, seed: 1));

  double seed = 1;

  void seedValue(double val) {
    seed = val;
    emit(CounterInitial(countValue: state.countValue, seed: seed));
  }

  void increment() {
    emit(
      CounterInitial(
        countValue: state.countValue + seed.toInt(),
        seed: seed,
      ),
    );
  }

  void decrement() {
    emit(
      CounterInitial(
        countValue: state.countValue - seed.toInt(),
        seed: seed,
      ),
    );
  }

  void refresh() {
    seed = 1;

    emit(
      CounterInitial(
        countValue: 0,
        seed: 1,
      ),
    );
  }
}
