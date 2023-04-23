import "package:counter_app/ui/home.dart";
import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWrapper(),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.lightBlue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
