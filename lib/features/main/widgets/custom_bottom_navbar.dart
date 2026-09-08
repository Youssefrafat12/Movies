import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function onTap;
  const CustomBottomNavbar({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: kBottomNavigationBarHeight + 4,
          clipBehavior: .antiAlias,
          decoration: BoxDecoration(borderRadius: .circular(16)),
          margin: const .symmetric(horizontal: 12),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColors.darkGreyColor,
            onTap: (index) {
              onTap(index);
            },
            currentIndex: index,
            type: .fixed,
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.homeIcon,
                  colorFilter: ColorFilter.mode(AppColors.primaryColor, .srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.homeIcon),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.searchIcon,
                  colorFilter: ColorFilter.mode(AppColors.primaryColor, .srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.searchIcon),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.exploreIcon,
                  colorFilter: ColorFilter.mode(AppColors.primaryColor, .srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.exploreIcon),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppAssets.profileIcon,
                  colorFilter: ColorFilter.mode(AppColors.primaryColor, .srcIn),
                ),
                icon: SvgPicture.asset(AppAssets.profileIcon),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
