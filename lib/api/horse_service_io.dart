import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_little_poney/models/Horse.dart';

int statusOk = 200;

class HorseServiceApi {
  Future<List<Horse>> getAll() async {
    final response = await http.Client()
        .get(Uri.parse('https://my-little-poney.herokuapp.com/horses'));
    log(response.body.toString());
    if (response.statusCode == statusOk) {
      return compute(parseHorses, response.body);
    } else {
      throw Exception('Failed to load horses');
    }
  }

  Future<Horse> fetchHorseById(id) async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/horses/$id'));
    if (response.statusCode == 200) {
      return Horse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load horse');
    }
  }

  Future<Horse> createHorse(Horse horse) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/horses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: horse.toJson(),
    );

    if (response.statusCode == 201) {
      // si on recupere le horse crée
      return Horse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create horse.');
    }
  }

  Future<Horse> updateHorse(Horse horse) async {
    final response = await http.put(
      Uri.parse('https://my-little-poney.herokuapp.com/horses/${horse.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: horse.toJson(),
    );

    if (response.statusCode == 200) {
      return Horse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update horse.');
    }
  }

  Future<Horse> deleteHorse(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://my-little-poney.herokuapp.com/horses/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Horse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete horse.');
    }
  }

}

List<Horse> parseHorses(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Horse>((json) {
    return Horse.fromJson(json);
  }).toList();
}
