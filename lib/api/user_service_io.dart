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
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: user.toJson(),
    );

    if (response.statusCode == 201) {
      // si on recupere le user crée
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('https://my-little-poney.herokuapp.com/users/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user.');
    }
  }

  Future<User> deleteUser(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://my-little-poney.herokuapp.com/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete user.');
    }
  }

  List<User> parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<User>((json) {
      return User.fromJson(json);
    }).toList();
  }
}