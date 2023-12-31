import 'package:exschool/ui/widgets/customShimmerContainer.dart';
import 'package:exschool/ui/widgets/shimmerLoadingContainer.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class AnnouncementShimmerLoadingContainer extends StatelessWidget {
  const AnnouncementShimmerLoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.0),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12.5),
      width: MediaQuery.of(context).size.width * (0.8),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: 4.0,
              width: boxConstraints.maxWidth * (0.65),
            )),
            SizedBox(
              height: 10,
            ),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: 3.0,
              width: boxConstraints.maxWidth * (0.5),
            )),
            SizedBox(
              height: 20,
            ),
            ShimmerLoadingContainer(
                child: CustomShimmerContainer(
              borderRadius: 3.0,
              height: UiUtils.shimmerLoadingContainerDefaultHeight - 2,
              width: boxConstraints.maxWidth * (0.3),
            )),
          ],
        );
      }),
    );
  }
}
