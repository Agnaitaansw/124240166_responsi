import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/spell_model.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';
import '../utils/snackbar_helper.dart';
import 'favorite_spells_page.dart';
import 'login_page.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({super.key});

  @override
  State<SpellsPage> createState() => _SpellsPageState();
}

class _SpellsPageState extends State<SpellsPage> {
  late Future<List<SpellModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.getSpells().then(
      (maps) => maps.map((map) => SpellModel.fromJson(map)).toList(),
    );
  }

  Future<void> _toggleFavorite(SpellModel spell) async {
    final added = await FavoriteService.toggle(spell);
    setState(() {});

    if (added) {
      showTopSnackBar(
        title: 'Add!',
        message: '${spell.spell} successfully added to fav list',
        success: true,
      );
    } else {
      showTopSnackBar(
        title: 'Remove!',
        message: '${spell.spell} removed from fav list',
        success: false,
      );
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('username');

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
    showTopSnackBar(
      title: 'Success!',
      message: 'Logged out Successfully',
      success: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<List<SpellModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final spells = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: spells.length,
            itemBuilder: (context, i) {
              final s = spells[i];
              final isFav = FavoriteService.isFavorite(s.index);
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(s.spell),
                  subtitle: Text(s.use),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFav ? Colors.red : Colors.grey.shade700,
                    ),
                    onPressed: () => _toggleFavorite(s),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FavoriteSpellsPage()),
          );
          // refresh status favorite setelah kembali dari halaman favorite
          setState(() {});
        },
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Characters'),
          ),
        ),
      ),
    );
  }
}
