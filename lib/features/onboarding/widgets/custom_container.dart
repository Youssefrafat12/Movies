import 'package:flutter/material.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String text1;
  final String? text2;
  final String nameButton1;
  final String? nameButton2;
  final VoidCallback onPressedButton1;
  final VoidCallback? onPressedButton2;
  const CustomContainer({
    super.key,
    required this.image,
    required this.text1,
    this.text2,
    required this.onPressedButton1,
    this.onPressedButton2,
    required this.nameButton1,
    this.nameButton2,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(image, fit: BoxFit.cover)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: context.width * 0.05,
              right: context.width * 0.05,
              top: height * 0.04,
              bottom: height * 0.02,
            ),
            decoration: BoxDecoration(
              color: AppColors.blackColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(41),
                topRight: Radius.circular(41),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text1,
                  textAlign: TextAlign.center,
                  style: AppStyles.bold24White,
                ),
                SizedBox(height: height * 0.017),
                if (text2 != null)
                  Text(
                    text2!,
                    textAlign: TextAlign.center,
                    style: AppStyles.regular20White,
                  ),
                SizedBox(height: height * 0.027),
                CustomElevatedButton(
                  style: AppStyles.semi20Black,
                  onPressedButton2: onPressedButton1,
                  title: nameButton1,
                ),
                SizedBox(height: height * 0.014),
                if (nameButton2 != null)
                  CustomElevatedButton(
                    side: BorderSide(),
                    style: AppStyles.semi20Primary,
                    bgColor: AppColors.blackColor,
                    onPressedButton2: onPressedButton2!,
                    title: nameButton2!,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
