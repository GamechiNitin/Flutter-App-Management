import 'package:codecamp/chapter_1/cubit/random_name_cubit.dart';
import 'package:flutter/material.dart';

class PickRandomNamesScreenSTF extends StatefulWidget {
  const PickRandomNamesScreenSTF({super.key});

  @override
  State<PickRandomNamesScreenSTF> createState() => _PickRandomNamesScreenSTFState();
}

class _PickRandomNamesScreenSTFState extends State<PickRandomNamesScreenSTF> {
  late final RandomNameCubit _randomNameCubit;

  @override
  initState() {
    _randomNameCubit = RandomNameCubit();
    super.initState();
  }

  @override
  void dispose() {
    _randomNameCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          "Pick Random Name Using Stateful Widget",
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
    );
  }
}
