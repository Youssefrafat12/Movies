import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class CustomColumn extends StatelessWidget {
  final String label_1;
  final String label_2;
  final int count_1;
  final int count_2;

  const CustomColumn({
    super.key,
    required this.label_1,
    required this.label_2,
    required this.count_1,
    required this.count_2,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    return Row(
      spacing: width * 0.08,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          spacing: height * 0.012,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$count_1', style: AppStyles.bold24White),
            Text(label_1, style: AppStyles.bold24White),
          ],
        ),
        Column(
          spacing: height * 0.012,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$count_2', style: AppStyles.bold24White),
            Text(label_2, style: AppStyles.bold24White),
          ],
        ),
      ],
    );
  }
}
