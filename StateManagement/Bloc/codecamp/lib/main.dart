import 'package:codecamp/chapter_5/ui/home_5.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        Chapter : 4
          home: const Home4Screen(),

      */
      home: const Home5Screen(),
    );
  }
}
