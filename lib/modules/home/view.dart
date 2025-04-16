import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/search_page.dart';
import 'state.dart';
import 'widgets/custom_navbar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);

    return Scaffold(
      body: IndexedStack(
        index: homeState.currentIndex,
        children: const [
          HomePage(),
          SearchPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const CustomNavbar(),
    );
  }
}
