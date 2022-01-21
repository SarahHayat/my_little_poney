import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_little_poney/models/User.dart';

class UserServiceApi {
  Future<List<User>> getAll() async {
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

  Future<User> loggin(String email,String password) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (jsonDecode(response.body)['userName'] != null) {
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      jsonDecode(response.body);
      throw Exception('Failed to load user');
    }
  }

  Future<List<User>> fetchUsersByIds(List<String> ids) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/users/ids'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, List<String>>{
        'ids': ids,
      }),
    );
    if (response.statusCode == 201) {
      List<User> users = [];
      for (dynamic element in jsonDecode(response.body)) {
        users.add(User.fromJson(element));
      }
      // print(users);
      return users;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> resetPassword(String email,String userName) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/users/forget'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'userName': userName,
      }),
    );
    if (jsonDecode(response.body)['userName'] != null) {
      User user = User.fromJson(jsonDecode(response.body));
      return user;
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
      body: jsonEncode(user.toJson()),
    );

    if (jsonDecode(response.body)['userName'] != null) {
      // si on recupere le user crée
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw Exception('Failed to create io user.');
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.patch(
      Uri.parse('https://my-little-poney.herokuapp.com/users/${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
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