import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieGridSkeleton extends StatelessWidget {
  final int itemCount;

  const MovieGridSkeleton({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 189 / 279,
        mainAxisSpacing: height * 0.016,
        crossAxisSpacing: width * 0.04,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade800,
          highlightColor: Colors.grey.shade600,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: width * 0.03,
                  left: width * 0.02,
                  child: Container(
                    width: width * 0.15,
                    height: height * 0.035,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
