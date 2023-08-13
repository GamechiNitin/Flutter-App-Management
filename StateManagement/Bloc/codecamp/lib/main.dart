import 'package:flutter/material.dart';

import 'chapter_1/pick_random_name_stl.dart';
import 'chapter_2/person_screen.dart';
import 'chapter_3/ui/home_3.dart';
import 'chapter_4/ui/home_4.dart';
import 'chapter_5/ui/home_5.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (chapter == 5) {
    // await Firebase.initializeApp();
    runApp(const MyApp());
  } else {
    runApp(const MyApp());
  }
}

int chapter = 5;

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
      home: app(chapter),
    );
  }
}

Widget app(int chapter) {
  switch (chapter) {
    case 1:
      return const PickRandomNamesScreenSTL();
    case 2:
      return const PersonScreen();
    case 3:
      return const Home3Screen();
    case 4:
      return const Home4Screen();
    case 5:
      return const Home5Screen();
    default:
      return const PickRandomNamesScreenSTL();
  }
}
