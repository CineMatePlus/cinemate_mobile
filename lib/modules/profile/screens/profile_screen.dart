import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_section.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: const CustomAppBar(
        title: 'Profil',
        showBackButton: false,
      ),
      body: profileState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : profileState.error != null
              ? Center(
                  child: Text(
                    profileState.error!,
                    style: const TextStyle(
                      color: ThemeConstants.textColor,
                    ),
                  ),
                )
              : profileState.user == null
                  ? const Center(
                      child: Text(
                        'Kullanıcı bulunamadı',
                        style: TextStyle(
                          color: ThemeConstants.textColor,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileHeader(user: profileState.user!),
                          const SizedBox(height: 32),
                          ProfileSection(
                            title: 'Favorilerim',
                            movieIds: profileState.user!.favoriteMovies,
                            onSeeAll: () {
                              // TODO: Navigate to favorites screen
                            },
                          ),
                          const SizedBox(height: 32),
                          ProfileSection(
                            title: 'İzleme Listem',
                            movieIds: profileState.user!.watchlist,
                            onSeeAll: () {
                              // TODO: Navigate to watchlist screen
                            },
                          ),
                          const SizedBox(height: 32),
                          ProfileSection(
                            title: 'İzlediklerim',
                            movieIds: profileState.user!.watchedMovies,
                            onSeeAll: () {
                              // TODO: Navigate to watched movies screen
                            },
                          ),
                        ],
                      ),
                    ),
    );
  }
}
