import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../database/poke_database.dart';
import '../models/poke_model.dart';

class PokeRepository {
  final String _baseUrl = "https://pokeapi.co/api/v2/pokemon";

  getPoke({String? name}) async {
    name ??= Random().nextInt(1010).toString();

    // Get a poke from cache
    final cachedPoke = await PokeDatabase.instance.getPoke(name);
    if (cachedPoke != null) {
      return cachedPoke;
    }

    final uri = Uri.parse("$_baseUrl/$name");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final poke = PokeModel.fromJson(jsonDecode(response.body));
      await PokeDatabase.instance.addPoke(poke);
      return poke;
    } else {
      throw Exception("Failed to get Pokemon");
    }
  }
}
