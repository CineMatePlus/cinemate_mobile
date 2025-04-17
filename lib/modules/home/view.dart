import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/theme_constants.dart';
import '../../core/providers/theme_provider.dart';
import '../profile/screens/profile_view.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'state.dart';
import 'widgets/custom_navbar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    // Tema'ya göre renkleri ayarla
    final backgroundColor = isDarkMode
        ? ThemeConstants.darkBackgroundColor
        : ThemeConstants.lightBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: IndexedStack(
        index: homeState.currentIndex,
        children: const [
          HomePage(),
          SearchPage(),
          // ProfilePage()
          ProfileView(),
        ],
      ),
      bottomNavigationBar: const CustomNavbar(),
    );
  }
}
