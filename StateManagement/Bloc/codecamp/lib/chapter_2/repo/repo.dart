import 'dart:convert';
import 'dart:io';

import 'package:codecamp/chapter_2/model/person.dart';
import 'package:flutter/services.dart';

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url)) // URL : HttpClientRequest
    .then((value) => value.close()) // Close : HttpClientRequest
    .then((value) =>
        value.transform(utf8.decoder).join()) // HttpClientResponse => String
    .then((value) =>
        json.decode(value) as List<dynamic>) // String => List<dynamic>
    .then((value) => value
        .map((e) => Person.fromJson(e))); // List<dynamic> => Iterable<Person>

Future<Iterable<Person>> getLocalPerson(String url) async {
  final data = await rootBundle.loadString(url);
  final resposne = json.decode(data) as List<dynamic>;
  return resposne.map((e) => Person.fromJson(e));
}
