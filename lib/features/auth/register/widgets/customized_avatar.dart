import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class CustomizedAvatar extends StatelessWidget {
  final String imagePath;
  final double size;
  final VoidCallback onTap;
  final bool isSelected;

  const CustomizedAvatar({
    super.key,
    required this.imagePath,
    required this.size,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.darkGreyColor,
        ),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
