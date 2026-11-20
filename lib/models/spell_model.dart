import 'dart:convert';

class SpellModel {
  final int index;
  final String spell;
  final String use;

  SpellModel({
    required this.index,
    required this.spell,
    required this.use,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) {
    return SpellModel(
      index: json['index'] ?? 0,
      spell: json['spell']?.toString() ?? '-',
      use: json['use']?.toString() ?? '-',
    );
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'spell': spell,
        'use': use,
      };

  String toJsonString() => jsonEncode(toJson());

  factory SpellModel.fromJsonString(String source) =>
      SpellModel.fromJson(jsonDecode(source));
}