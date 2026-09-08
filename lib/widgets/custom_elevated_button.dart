import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressedButton2;
  final Color? bgColor;
  final TextStyle style;
  final Widget? child;
  final BorderSide? side;
  final bool isExitButton;
  final bool isLoading;
  const CustomElevatedButton({
    super.key,
    required this.onPressedButton2,
    required this.title,
    this.bgColor = AppColors.primaryColor,
    required this.style,
    this.child,
    this.side,
    this.isExitButton = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: .symmetric(vertical: 15),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: side == null
            ? null
            : BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      onPressed: onPressedButton2,
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: AppColors.blackColor),
            )
          : Row(
              textDirection: isExitButton ? .rtl : .ltr,
              spacing: child == null ? 0 : 12,
              mainAxisAlignment: .center,
              children: [
                child ?? SizedBox(),
                Text(title, style: style),
              ],
            ),
    );
  }
}
