import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieCarouselSkeleton extends StatelessWidget {
  const MovieCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.36,
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          return SizedBox(
            width: width * 0.5,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade600,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: false,
          height: height * 0.36,
          enlargeCenterPage: true,
          viewportFraction: 0.5,
        ),
      ),
    );
  }
}
