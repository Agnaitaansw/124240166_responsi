import 'package:hive_flutter/hive_flutter.dart';

import '../models/spell_model.dart';

/// Penyimpanan favorite spell menggunakan Hive.
/// Key = index spell (String), Value = JSON string spell.
class FavoriteService {
  static const String boxName = 'favorite_spells';

  static Box<String> get _box => Hive.box<String>(boxName);

  static bool isFavorite(int index) => _box.containsKey(index.toString());

  static Future<void> add(SpellModel spell) =>
      _box.put(spell.index.toString(), spell.toJsonString());

  static Future<void> remove(int index) => _box.delete(index.toString());

  /// Toggle favorite. Return true jika ditambahkan, false jika dihapus.
  static Future<bool> toggle(SpellModel spell) async {
    if (isFavorite(spell.index)) {
      await remove(spell.index);
      return false;
    } else {
      await add(spell);
      return true;
    }
  }

  static List<SpellModel> getAll() =>
      _box.values.map((e) => SpellModel.fromJsonString(e)).toList();
}