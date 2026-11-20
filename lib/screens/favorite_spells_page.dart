import 'package:flutter/material.dart';

import '../models/spell_model.dart';
import '../services/favorite_service.dart';

class FavoriteSpellsPage extends StatefulWidget {
  const FavoriteSpellsPage({super.key});

  @override
  State<FavoriteSpellsPage> createState() => _FavoriteSpellsPageState();
}

class _FavoriteSpellsPageState extends State<FavoriteSpellsPage> {
  List<SpellModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() => _favorites = FavoriteService.getAll());
  }

  Future<void> _delete(SpellModel spell) async {
    await FavoriteService.remove(spell.index);
    _load();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Spell')),
      body: _favorites.isEmpty
          ? const Center(child: Text('Belum ada spell favorite'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _favorites.length,
              itemBuilder: (context, i) {
                final s = _favorites[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(s.spell),
                    subtitle: Text(s.use),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _delete(s),
                    ),
                  ),
                );
              },
            ),
    );
  }
}