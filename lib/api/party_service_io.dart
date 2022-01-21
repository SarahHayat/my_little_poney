import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_little_poney/models/Party.dart';

class PartyServiceApi {
  Future<List<Party>?> getAll() async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/parties'));
    if (response.statusCode == 200) {
      return compute(parseParties, response.body);
    } else {
      throw Exception('Failed to load parties');
    }
  }

  Future<Party> fetchPartyById(id) async {
    final response = await http
        .get(Uri.parse('https://my-little-poney.herokuapp.com/parties/$id'));
    if (response.statusCode == 200) {
      return Party.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load party');
    }
  }
  Future<Party> createParty(Party party) async {
    final response = await http.post(
      Uri.parse('https://my-little-poney.herokuapp.com/parties'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: party.toJson(),
    );

    if (response.statusCode == 201) {
      // si on recupere la party crée
      return Party.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create party.');
    }
  }

  Future<Party?> updateParty(Party party) async {
    log(party.toJson().toString());
    final response = await http.patch(
      Uri.parse('https://my-little-poney.herokuapp.com/parties/${party.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(party.toJson()),
    );

    if (response.statusCode == 200) {
      return Party.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update party ${party.id}. code error : ${response.statusCode}');
    }
  }

  Future<Party> deleteParty(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://my-little-poney.herokuapp.com/parties/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Party.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete party.');
    }
  }

  List<Party> parseParties(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Party>((json) {
      return Party.fromJson(json);
    }).toList();
  }
}
