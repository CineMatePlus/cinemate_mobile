import 'package:cinemate_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../modules/common/widgets/theme_switch.dart';
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
    final profileState = ref.watch(profileProvider);
    final userState = ref.watch(userProvider);

    // Tema renklerini doğrudan almak:
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          'Profil',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: primaryColor),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileView()),
            ),
          ),
        ],
      ),
      body: profileState.isLoading
          ? Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileInfo(userState, primaryColor, textColor),
                  Divider(color: Colors.grey.withOpacity(0.3)),
                  _buildSettingsList(userState, primaryColor, textColor),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileInfo(
      UserState user, Color primaryColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: primaryColor.withOpacity(0.2),
            child: const CircleAvatar(
              radius: 58,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/203699449?v=4'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.user?.name ?? 'Ad Soyad',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.user?.email ?? 'email@example.com',
            style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList(
      UserState user, Color primaryColor, Color textColor) {
    return Column(
      children: [
        _settingTile(
          icon: Icons.dark_mode,
          title: 'Karanlık Mod',
          trailing: const ThemeSwitch(showLabel: false),
          primaryColor: primaryColor,
          textColor: textColor,
        ),
        _settingTile(
          icon: Icons.logout,
          title: 'Çıkış Yap',
          onTap: () => ref.read(profileProvider.notifier).logout(context),
          primaryColor: primaryColor,
          textColor: textColor,
        ),
        _settingTile(
          icon: Icons.developer_mode,
          title: 'Onboarding Sıfırla (Developer)',
          onTap: () => SecureStorageUtils.resetOnboarding(),
          primaryColor: primaryColor,
          textColor: textColor,
        ),
      ],
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    required Color primaryColor,
    required Color textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: primaryColor,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
