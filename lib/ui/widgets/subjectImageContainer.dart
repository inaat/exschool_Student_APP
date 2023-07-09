import 'package:cached_network_image/cached_network_image.dart';
import 'package:exschool/data/models/subject.dart';
import 'package:exschool/ui/widgets/subjectFirstLetterContainer.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubjectImageContainer extends StatelessWidget {
  final Subject subject;
  final double height;
  final double width;
  final double radius;
  final BoxBorder? border;
  final bool showShadow;
  const SubjectImageContainer(
      {Key? key,
      this.border,
      required this.showShadow,
      required this.height,
      required this.radius,
      required this.subject,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: subject.image.isEmpty
            ? SubjectFirstLetterContainer(
                subjectName: subject.name,
              )
            : subject.isSubjectImageSvg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * (0.25), vertical: height * 0.25),
                    child: SvgPicture.network(subject.image),
                  )
                : SizedBox(),
        decoration: BoxDecoration(
            border: border,
            image: subject.image.isEmpty || subject.isSubjectImageSvg
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(subject.image)),
            boxShadow: showShadow
                ? [
                    BoxShadow(
                        color: UiUtils.getColorFromHexValue(subject.bgColor)
                            .withOpacity(0.2),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 0)
                  ]
                : null,
            color: UiUtils.getColorFromHexValue(subject.bgColor),
            borderRadius: BorderRadius.circular(radius)),
        height: height,
        width: width);
  }
}
