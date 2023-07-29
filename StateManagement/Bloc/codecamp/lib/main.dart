import 'package:codecamp/chapter_3/ui/home_3.dart';
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

      home: const Home3Screen(),
    );
  }
}
