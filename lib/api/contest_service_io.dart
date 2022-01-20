import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_little_poney/models/Contest.dart';

class ContestServiceApi {
  Future<List<Contest>?> getAll() async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/contests'));
    if (response.statusCode == 200) {
      return compute(parseContests, response.body);
    } else {
      throw Exception('Failed to load contests');
    }
  }

  Future<Contest> fetchContestById(id) async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/contests/$id'));
    if (response.statusCode == 200) {
      return Contest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load contest');
    }
  }


  Future<Contest> createContest(Contest contest) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/contests'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: contest.toJson(),
    );

    if (response.statusCode == 201) {
      // si on recupere le contest crée
      return Contest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create contest.');
    }
  }

  Future<Contest> updateContest(Contest contest) async {
    final response = await http.put(
      Uri.parse('https://my-little-poney.herokuapp.com/contests/${contest.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: contest.toJson(),
    );

    if (response.statusCode == 200) {
      return Contest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update album.');
    }
  }

  Future<Contest> deleteContest(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://my-little-poney.herokuapp.com/contests/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Contest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete contest.');
    }
  }

}

List<Contest> parseContests(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Contest>((json) {
    return Contest.fromJson(json);
  }).toList();
}