import 'package:codecamp/chapter_2/person_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      /*
        Chapter : 1
          home: const PickRandomNamesScreenSTL(),
        Chapter : 2
          home: const PersonScreen(),

      */

      home: const PersonScreen(),
    );
  }
}
