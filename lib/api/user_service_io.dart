import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_little_poney/models/User.dart';

class UserServiceApi {
  Future<List<User>?> getAll() async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/users'));
    if (response.statusCode == 200) {
      return compute(parseUsers, response.body);
    } else {
      throw Exception('Failed to load activities');
    }
  }

  Future<User> fetchUserById(id) async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}

List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) {
    return User.fromJson(json);
  }).toList();
}
