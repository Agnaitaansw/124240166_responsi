import 'package:flutter/material.dart';

import '../models/character_model.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;
  const CharacterDetailPage({super.key, required this.character});

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = character;
    return Scaffold(
      appBar: AppBar(title: Text(c.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  c.image,
                  height: 320,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, size: 120),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _row('Index', c.index.toString()),
            _row('title', c.title),
            _row('originalTitle', c.originalTitle),
            _row('releaseDate', c.releaseDate),
            _row('pages', c.pages),
            _row('description', c.description),
            _row('Children',
                c.children.isEmpty ? '-' : c.children.join(', ')),
            _row('Image URL', c.image),
          ],
        ),
      ),
    );
  }
}