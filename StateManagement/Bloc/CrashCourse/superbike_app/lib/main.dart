import 'package:flutter/material.dart';
import 'package:superbike_app/features/home/ui/home.dart';

void main() {
  runApp(const MyApp());
}

/*
 |::::::::::::::::|:::::::::::::|:::::::::::::|
 |                                            |
 |    Event      ==>    Bloc   ==>  State     |
 |                                            |
 |::::::::::::::::|:::::::::::::|:::::::::::::|

  Event => Action or Interaction done by the user are event.
  State => Whatever is visible on the screen is a state.
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SuperBike App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
