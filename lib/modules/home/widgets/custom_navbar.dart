import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../state.dart';

class CustomNavbar extends ConsumerWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);
    final notifier = ref.read(homeStateProvider.notifier);

    // Tema renklerini direk olarak almak:
    final backgroundColor = ThemeConstants.getSurfaceColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);

    return BottomNavigationBar(
      currentIndex: homeState.currentIndex,
      onTap: (index) => notifier.setCurrentIndex(index),
      backgroundColor: backgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textColor.withOpacity(0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Ara',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
