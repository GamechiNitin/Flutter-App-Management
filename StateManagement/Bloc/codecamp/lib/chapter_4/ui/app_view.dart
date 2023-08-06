import 'package:codecamp/chapter_4/bloc/app/app_bloc.dart';
import 'package:codecamp/chapter_4/extension/stream/start_with.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView<T extends AppBloc> extends StatelessWidget {
  const AppView({super.key});
  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (_) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, state) {
          if (state.error != null) {
            return const Center(
                child: Text("An error occured. Try again in a momment"));
          } else if (state.data != null) {
            return Image.network(
              state.data!,
              fit: BoxFit.cover,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
