import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/text_styles.dart';
import '../models/onboarding_item.dart';
import 'state.dart';

class OnboardingView extends ConsumerStatefulWidget {
  final VoidCallback onComplete;
  const OnboardingView({super.key, required this.onComplete});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(onboardingStateProvider.notifier).loadOnboardingData());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingStateProvider);

    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  ref
                      .read(onboardingStateProvider.notifier)
                      .setCurrentPage(index);
                },
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return _OnboardingPage(item: item);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(onboardingStateProvider.notifier)
                          .setOnboardingCompleted();
                      widget.onComplete();
                    },
                    child: Text('Atla', style: AppTextStyles.bodyLarge),
                  ),
                  Row(
                    children: List.generate(
                      state.items.length,
                      (index) => _DotIndicator(
                        isActive: index == state.currentPage,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (state.currentPage == state.items.length - 1) {
                        ref
                            .read(onboardingStateProvider.notifier)
                            .setOnboardingCompleted();
                        widget.onComplete();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      state.currentPage == state.items.length - 1
                          ? 'Başla'
                          : 'İleri',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const _OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.image,
            height: 300,
          ),
          const SizedBox(height: 32),
          Text(
            item.title,
            style: AppTextStyles.heading2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            item.subtitle,
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isActive;

  const _DotIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade300,
      ),
    );
  }
}
