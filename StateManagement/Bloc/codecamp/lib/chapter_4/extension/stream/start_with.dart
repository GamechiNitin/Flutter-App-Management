import 'package:async/async.dart' show StreamGroup;
/*
this:         | ------------ X ----------X
Stream.value: | X |
merge:        | X ----------- X --------- X
*/

extension StartWith<T> on Stream<T>{
// Reactive Programming Style
Stream<T> startWith(T value) => StreamGroup.merge(
      [
        this,
        Stream<T>.value(value),
      ],
    );
}
