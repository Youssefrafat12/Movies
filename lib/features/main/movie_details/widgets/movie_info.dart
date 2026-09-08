import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieInfo extends StatelessWidget {
  final Object text;
  final String icon;
  const MovieInfo({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Container(
      padding: .symmetric(horizontal: width * 0.05, vertical: height * 0.007),
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        color: AppColors.darkGreyColor,
      ),
      child: Row(
        spacing: width * 0.028,
        mainAxisSize: .min,
        children: [
          SvgPicture.asset(icon),
          Text(text.toString(), style: AppStyles.bold22White),
        ],
      ),
    );
  }
}
