import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Film veya dizi ara...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              // TODO: Arama işlemi
            },
          ),
          const SizedBox(height: 20),
          // TODO: Arama sonuçları
          const Center(
            child: Text('Arama sonuçları burada gösterilecek'),
          ),
        ],
      ),
    );
  }
}
