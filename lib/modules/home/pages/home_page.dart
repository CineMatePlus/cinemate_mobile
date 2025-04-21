import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/content_section.dart';
import '../state/content_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // initState içinde ref.read yaparak veri yüklemeyi başlatıyoruz
    // Tüm veriler aynı anda yüklenecek
    Future.microtask(() => ref.read(contentProvider.notifier).loadAllData());
  }

  @override
  Widget build(BuildContext context) {
    final contentState = ref.watch(contentProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentSection(
            title: 'Tüm İçerikler',
            contents: contentState.allContents,
            status: contentState.allContentsStatus,
          ),
          const SizedBox(height: 20),
          ContentSection(
            title: 'Filmler',
            contents: contentState.movies,
            status: contentState.moviesStatus,
          ),
          const SizedBox(height: 20),
          ContentSection(
            title: 'Diziler',
            contents: contentState.series,
            status: contentState.seriesStatus,
          ),
        ],
      ),
    );
  }
}
