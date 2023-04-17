import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/poke_model.dart';

class PokeRepository {
  final String _baseUrl = "https://pokeapi.co/api/v2/pokemon";

  getPoke({String? name}) async {
    late final Uri uri;

    if (name == null) {
      final int randomId = Random().nextInt(1010);
      uri = Uri.parse("$_baseUrl/$randomId");
    } else {
      uri = Uri.parse("$_baseUrl/$name");
    }

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PokeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to get Pokemon");
    }
  }
}
