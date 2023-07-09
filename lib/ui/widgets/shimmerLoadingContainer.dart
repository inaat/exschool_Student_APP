import 'package:exschool/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingContainer extends StatelessWidget {
  final Widget child;
  const ShimmerLoadingContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: shimmerBaseColor,
      highlightColor: shimmerhighlightColor,
    );
  }
}
