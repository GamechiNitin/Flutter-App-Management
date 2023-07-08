import 'package:codecamp/chapter_1/cubit/random_name_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickRandomNamesScreenSTL extends StatelessWidget {
  const PickRandomNamesScreenSTL({super.key});

  static final RandomNameCubit _randomNameCubit = RandomNameCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _randomNameCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: const Text(
            "Pick Random Name Using Stateless Widget",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: StreamBuilder<String?>(
            stream: _randomNameCubit.stream,
            builder: (context, snapshot) {
              final button = TextButton(
                onPressed: () {
                  _randomNameCubit.pickRandomName();
                },
                child: const Text(
                  "Pick Random Name",
                ),
              );
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return button;
                case ConnectionState.waiting:
                  return button;
                case ConnectionState.active:
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 20),
                      button,
                    ],
                  );
                case ConnectionState.done:
                  return const SizedBox();
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
