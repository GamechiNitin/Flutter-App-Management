import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}
