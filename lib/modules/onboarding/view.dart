import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splash.view.dart';
import 'state.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    if (_pageController.page?.round() !=
        ref.read(onboardingStateProvider).currentPage) {
      ref
          .read(onboardingStateProvider.notifier)
          .setCurrentPage(_pageController.page?.round() ?? 0);
    }
  }

  Future<void> _completeOnboarding() async {
    final notifier = ref.read(onboardingStateProvider.notifier);
    await notifier.setOnboardingCompleted();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  void _nextPage() {
    final state = ref.read(onboardingStateProvider);
    if (state.currentPage < state.items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skip() => _completeOnboarding();

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);

    if (onboardingState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (onboardingState.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Hata: ${onboardingState.error}'),
        ),
      );
    }

    return Scaffold(
      body: onboardingState.items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingState.items.length,
                    onPageChanged: (index) => ref
                        .read(onboardingStateProvider.notifier)
                        .setCurrentPage(index),
                    itemBuilder: (context, index) {
                      final item = onboardingState.items[index];
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(item.image),
                            const SizedBox(height: 30),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                height: 1.8,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _skip,
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          onboardingState.items.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width:
                                onboardingState.currentPage == index ? 12 : 8,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: onboardingState.currentPage == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _nextPage,
                        child: Text(
                          onboardingState.currentPage ==
                                  onboardingState.items.length - 1
                              ? 'Finish'
                              : 'Next',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
