import 'package:cinemate_mobile/core/constants/colors.dart';
import 'package:cinemate_mobile/core/constants/text_styles.dart';
import 'package:cinemate_mobile/core/modules/auth/models/user.dart';
import 'package:cinemate_mobile/core/modules/auth/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Tab değiştiğinde ekranın yeniden çizilmesini sağlamak için dinleyici ekliyoruz.
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const Center(child: Text('User not logged in.'));
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildProfileHeader(user)),
        SliverPersistentHeader(
          delegate: _SliverAppBarDelegate(
            TabBar(
              controller: _tabController,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.textGrey,
              indicatorColor: AppColors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Lists'),
                Tab(text: 'Reviews'),
                Tab(text: 'Comments'),
              ],
            ),
          ),
          pinned: true,
        ),
        // Seçili sekmeye göre doğru içeriği gösteriyoruz.
        if (_tabController.index == 0)
          _buildMyListsSliver()
        else
          SliverFillRemaining(
            child: Center(
              child: Text(
                _tabController.index == 1
                    ? 'Reviews Coming Soon'
                    : 'Comments Coming Soon',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileHeader(User user) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage:
                AssetImage('lib/core/constants/assets/images/man_icon.png'),
          ),
          const SizedBox(height: 16),
          Text(user.name, style: AppTextStyles.heading2),
          const SizedBox(height: 4),
          Text('@${user.email.split('@').first}',
              style: AppTextStyles.bodyLarge.withColor(AppColors.textGrey)),
          const SizedBox(height: 4),
          Text('Joined 2024',
              style: AppTextStyles.bodyMedium.withColor(AppColors.lightGrey)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('12', 'Lists'),
              _buildStatCard('24', 'Followers'),
              _buildStatCard('10', 'Following'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.heading3),
          const SizedBox(height: 4),
          Text(label,
              style: AppTextStyles.bodyMedium.withColor(AppColors.textGrey)),
        ],
      ),
    );
  }

  // Bu fonksiyon artık bir "sliver" döndürüyor.
  Widget _buildMyListsSliver() {
    return SliverPadding(
      padding: const EdgeInsets.all(24),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Text('My Lists', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          _buildListItem(
            icon: Icons.favorite_border,
            title: 'Favorites',
            subtitle: '12 items',
          ),
          const SizedBox(height: 16),
          _buildListItem(
            icon: Icons.bookmark_border,
            title: 'Watch Later',
            subtitle: '10 items',
          ),
          const SizedBox(height: 16),
          _buildListItem(
            icon: Icons.movie_creation_outlined,
            title: 'Collections',
            subtitle: '5 items',
          ),
        ]),
      ),
    );
  }

  Widget _buildListItem(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.textGrey, size: 28),
      ),
      title: Text(title,
          style: AppTextStyles.bodyLarge.withWeight(FontWeight.bold)),
      subtitle: Text(subtitle,
          style: AppTextStyles.bodyMedium.withColor(AppColors.textGrey)),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
    );
  }
}

// Bu yardımcı sınıf, TabBar'ı bir sliver başlığı olarak sabitlemek için gereklidir.
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
