import 'package:flutter/material.dart';
import 'package:movies_app/features/main/tabs/browse/browse_tab.dart';
import 'package:movies_app/features/main/tabs/home/home_tab.dart';
import 'package:movies_app/features/main/tabs/profile/profile_tab.dart';
import 'package:movies_app/features/main/tabs/search/search_tab.dart';
import 'package:movies_app/features/main/widgets/custom_bottom_navbar.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final String? browseGenre;

  const MainScreen({super.key, this.initialIndex = 0, this.browseGenre});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex = widget.initialIndex;
  final homeKey = GlobalKey<HomeTabState>();

  late final tabs = [
    HomeTab(key: homeKey),
    SearchTab(),
    BrowseTab(initialGenre: widget.browseGenre),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: tabs[currentIndex],
      bottomNavigationBar: CustomBottomNavbar(
        index: currentIndex,
        onTap: (index) {
          if (index == 0) {
            homeKey.currentState?.refreshGenre();
          }
          if (index == 2) {
            tabs[2] = const BrowseTab();
          }
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
