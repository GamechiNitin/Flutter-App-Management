import 'package:codecamp/chapter_4/bloc/app/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({
    Duration? waitbeforeLoading,
    required Iterable<String> urls,
  }) : super(
          urls: urls,
          waitbeforeLoading: waitbeforeLoading,
        );
}
