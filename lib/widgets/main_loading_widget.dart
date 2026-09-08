import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MainLoadingwidget extends StatelessWidget {
  const MainLoadingwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    );
  }
}
