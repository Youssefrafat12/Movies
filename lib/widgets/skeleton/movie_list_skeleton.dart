import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieListSkeleton extends StatelessWidget {
  const MovieListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: width * 0.035),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      separatorBuilder: (context, index) {
        return SizedBox(width: width * 0.035);
      },
      itemBuilder: (context, index) {
        return SizedBox(
          width: width * 0.33,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade600,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsetsDirectional.only(
                start: width * 0.02,
                top: width * 0.03,
              ),
              child: Container(
                width: width * 0.15,
                height: height * 0.035,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
