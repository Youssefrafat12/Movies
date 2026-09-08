import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';

class UpdateProfileAvatar extends StatelessWidget {
  final String selectedAvatar;
  final Function(String) onAvatarSelected;

  const UpdateProfileAvatar({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  static List<String> avatars = [
    AppAssets.profileImage1,
    AppAssets.profileImage2,
    AppAssets.profileImage3,
    AppAssets.profileImage4,
    AppAssets.profileImage5,
    AppAssets.profileImage6,
    AppAssets.profileImage7,
    AppAssets.profileImage8,
    AppAssets.profileImage9,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: avatars.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedAvatar == avatars[index];

          return GestureDetector(
            onTap: () {
              onAvatarSelected(avatars[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: Image.asset(avatars[index], fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
