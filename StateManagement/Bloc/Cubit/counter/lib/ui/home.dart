import 'package:counter_app/cubit/counter_cubit.dart';
import 'package:counter_app/ui/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterInitial>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Counter App"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: state.countValue.toString(),
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "\nCurrent Counter",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          // color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text("Refresh"),
                  onPressed: () {
                    final provider = BlocProvider.of<CounterCubit>(context);
                    provider.refresh();
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SliderComponent(
                  seed: state.seed,
                  onChanged: (val) {
                    final double slider = val;
                    final provider = BlocProvider.of<CounterCubit>(context);
                    provider.seedValue(slider);
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final provider = BlocProvider.of<CounterCubit>(context);
                        provider.decrement();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepOrange),
                      ),
                      child: Text(
                        "Decrement",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final provider = BlocProvider.of<CounterCubit>(context);
                        provider.increment();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      child: Text(
                        "Increment",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
