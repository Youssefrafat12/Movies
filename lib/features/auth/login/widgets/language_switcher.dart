import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/utils/app_colors.dart';

class LanguageSwitcher extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageSwitcher({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          border: isSelected ? Border.all(color: AppColors.primaryColor) : null,
        ),
        child: SvgPicture.asset(icon, width: 20, height: 20),
      ),
    );
  }
}
