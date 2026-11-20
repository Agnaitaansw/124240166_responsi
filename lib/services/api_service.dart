import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/character_model.dart';
import '../models/spell_model.dart';

class ApiService {
String apiUrl1 = 'https://potterapi-fedeperin.vercel.app/en/books';
String apiUrl2 = 'https://potterapi-fedeperin.vercel.app/en/spells';

  Future<List<CharacterModel>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$apiUrl1?index=1'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => CharacterModel.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat karakter (${response.statusCode})');
  }

  Future<List<SpellModel>> fetchSpells() async {
    final response = await http.get(Uri.parse(apiUrl2));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => SpellModel.fromJson(e)).toList();
    }
    throw Exception('Gagal memuat spell (${response.statusCode})');
  }
}