import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieScreenShotsSkeleton extends StatelessWidget {
  const MovieScreenShotsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Container(
        width: double.infinity,
        height: height * 0.2,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
