import 'package:cinemate_mobile/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/theme_constants.dart';
import '../../../core/widgets/theme_switch.dart';
import '../../auth/state.dart';
import 'edit_screen/edit_view.dart';
import 'profil_state.dart';
import 'collections/collections_view.dart';
import 'collections/content_list_view.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(profileProvider.notifier).loadUserProfile();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      body: profileState.isLoading
          ? Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  backgroundColor: backgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            primaryColor.withOpacity(0.8),
                            backgroundColor,
                          ],
                        ),
                      ),
                      child:
                          _buildProfileInfo(userState, primaryColor, textColor),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.edit, color: primaryColor),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EditProfileView()),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'İçerik Listeleri',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildContentLists(primaryColor, textColor),
                        const SizedBox(height: 32),
                        Text(
                          'Ayarlar',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsList(userState, primaryColor, textColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProfileInfo(
      UserState user, Color primaryColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: primaryColor.withOpacity(0.2),
            child: _buildUserAvatar(user, 48),
          ),
          const SizedBox(height: 16),
          Text(
            user.user?.name ?? 'Ad Soyad',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.user?.email ?? 'email@example.com',
            style: TextStyle(
              fontSize: 16,
              color: textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(UserState userState, double radius) {
    final user = userState.user;

    // Avatar URL kontrolü
    if (user?.avatarUrl?.isNotEmpty ?? false) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(user!.avatarUrl!),
      );
    }

    // Cinsiyet bazlı asset seçimi
    final int gender = user?.gender ?? 2;

    // Erkek veya kadın ise asset kullan, diğer durumlarda icon
    return gender <= 1
        ? CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(gender == 0
                ? 'assets/images/woman_icon.png'
                : 'assets/images/man_icon.png'),
          )
        : CircleAvatar(
            radius: radius,
            child: Icon(
              Icons.person,
              size: radius * 1.2,
              color: Colors.grey[400],
            ),
          );
  }

  Widget _buildContentLists(Color primaryColor, Color textColor) {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildListCard(
            title: 'Beğenilenler',
            icon: Icons.favorite,
            backgroundColor: Colors.red.shade400,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ContentListView(
                  title: 'Beğenilenler',
                  source: ContentSource.liked,
                ),
              ),
            ),
          ),
          _buildListCard(
            title: 'İzlenenler',
            icon: Icons.visibility,
            backgroundColor: Colors.blue.shade400,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ContentListView(
                  title: 'İzlenenler',
                  source: ContentSource.watched,
                ),
              ),
            ),
          ),
          _buildListCard(
            title: 'İzlenecekler',
            icon: Icons.bookmark,
            backgroundColor: Colors.purple.shade400,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ContentListView(
                  title: 'İzlenecekler',
                  source: ContentSource.watchlist,
                ),
              ),
            ),
          ),
          _buildListCard(
            title: 'Koleksiyonlar',
            icon: Icons.folder,
            backgroundColor: Colors.amber.shade700,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CollectionsView()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor,
              backgroundColor.withOpacity(0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              right: 70,
              child: Icon(
                icon,
                size: 50,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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

  Widget _buildSettingsList(
      UserState user, Color primaryColor, Color textColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
