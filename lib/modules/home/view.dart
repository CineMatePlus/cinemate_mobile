import 'package:cinemate_mobile/core/constants/text_styles.dart';
import 'package:cinemate_mobile/modules/collections/screens/collections_list/view.dart';
import 'package:cinemate_mobile/modules/movie/screens/movie_list/view.dart';
import 'package:cinemate_mobile/modules/profile/view.dart';
import 'package:cinemate_mobile/modules/search/view.dart';
import 'package:cinemate_mobile/modules/similar_users/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const MovieListView(),
    const SearchView(),
    const SimilarUsersView(),
    const CollectionsListView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: _selectedIndex == 0
                    ? SvgPicture.asset(
                        'lib/core/constants/assets/images/logos/cinemate_minimalist.svg',
                        height: 50,
                        fit: BoxFit.contain,
                      )
                    : Text(
                        _getAppBarTitle(_selectedIndex),
                        style: AppTextStyles.heading2,
                      ),
              ),
              centerTitle: _selectedIndex == 0 ? true : false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: 60,
              actions: null,
              floating: true,
              snap: true,
            ),
          ];
        },
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildNavItem(
              'lib/core/constants/assets/images/home_icon.svg', 'Home', 0),
          _buildNavItem(
              'lib/core/constants/assets/images/search_icon.svg', 'Search', 1),
          _buildNavItem(
              'lib/core/constants/assets/images/nav_icon_2.svg', 'Cinema', 2),
          _buildNavItem('lib/core/constants/assets/images/nav_icon_3.svg',
              'Collections', 3),
          _buildNavItem(
              'lib/core/constants/assets/images/nav_icon_4.svg', 'Profile', 4),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 1,
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String iconPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          _selectedIndex == index
              ? const Color(0xFF0F1417)
              : const Color(0xFF5C738A),
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
      case 2:
        return 'Similar Users';
      case 3:
        return 'Collections';
      case 4:
        return 'Profile';
      default:
        return 'CineMate';
    }
  }
}
