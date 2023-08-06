import 'package:codecamp/chapter_4/bloc/app/app_bloc.dart';

class BottomBloc extends AppBloc {
  BottomBloc({
    Duration? waitbeforeLoading,
    required Iterable<String> urls,
  }) : super(
          urls: urls,
          waitbeforeLoading: waitbeforeLoading,
        );
}
