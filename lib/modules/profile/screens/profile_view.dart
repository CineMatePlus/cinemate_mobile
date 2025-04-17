import 'package:cinemate_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../user/state.dart';
import 'edit_screen/edit_view.dart';
import 'profil_state.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(profileProvider.notifier).loadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeConstants.backgroundColor,
        title: const Text(
          'Profil',
          style: TextStyle(
            color: ThemeConstants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: ThemeConstants.primaryColor),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileView()),
            ),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileInfo(user),
                  const Divider(),
                  _buildSettingsList(state, user),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileInfo(UserState user) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: ThemeConstants.primaryColor.withOpacity(0.2),
            child: const CircleAvatar(
              radius: 58,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/203699449?v=4'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.user?.name ?? 'Ad Soyad',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ThemeConstants.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text('@${user.user?.name ?? 'Ad Soyad'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Text(user.user?.email ?? 'email@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildSettingsList(ProfileState state, UserState user) {
    return Column(
      children: [
        _settingTile(
          icon: Icons.dark_mode,
          title: 'Karanlık Mod',
          trailing: Switch(
            value: state.isDarkMode,
            onChanged: (value) =>
                ref.read(profileProvider.notifier).updateTheme(value),
            activeColor: ThemeConstants.primaryColor,
          ),
        ),
        _settingTile(
          icon: Icons.logout,
          title: 'Çıkış Yap',
          onTap: () => ref.read(profileProvider.notifier).logout(context),
        ),
        _settingTile(
          icon: Icons.developer_mode,
          title: 'Onboarding Sil(Developer)',
          onTap: () => SecureStorageUtils.resetOnboarding(),
        ),
      ],
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: ThemeConstants.primaryColor),
      title: Text(title,
          style: const TextStyle(
            fontSize: 16,
            color: ThemeConstants.primaryColor,
          )),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
