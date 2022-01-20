import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_little_poney/models/Lesson.dart';

class LessonServiceApi {
  Future<List<Lesson>?> getAll() async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/lessons'));
    if (response.statusCode == 200) {
      return compute(parseLessons, response.body);
    } else {
      throw Exception('Failed to load lessons');
    }
  }

  Future<Lesson> fetchLessonById(id) async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/lessons/$id'));
    if (response.statusCode == 200) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load lesson');
    }
  }

  Future<Lesson> createLesson(Lesson lesson) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/lessons'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: lesson.toJson(),
    );

    if (response.statusCode == 201) {
      // si on recupere la lesson crée
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create lesson.');
    }
  }

  Future<Lesson> updateLesson(Lesson lesson) async {
    final response = await http.put(
      Uri.parse('https://my-little-poney.herokuapp.com/lessons/${lesson.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: lesson.toJson(),
    );

    if (response.statusCode == 200) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update lesson.');
    }
  }

  Future<Lesson> deleteLesson(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://my-little-poney.herokuapp.com/lessons/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Lesson.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete lesson.');
    }
  }

}

List<Lesson> parseLessons(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Lesson>((json) {
    return Lesson.fromJson(json);
  }).toList();
}
