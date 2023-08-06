import 'package:codecamp/chapter_4/ui/home_4.dart';
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
        Chapter : 3
          home: const Home3Screen(),

      */
      home: const Home4Screen(),
    );
  }
}
