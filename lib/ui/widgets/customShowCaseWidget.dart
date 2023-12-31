import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowCaseWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final ShapeBorder? shapeBorder;
  final String description;
  final Widget child;
  const CustomShowCaseWidget(
      {Key? key,
      required this.globalKey,
      required this.description,
      this.shapeBorder,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase(
        showArrow: false,
       // overlayPadding: EdgeInsets.only(top: 5),
        textColor: Theme.of(context).colorScheme.secondary,
       // showcaseBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //shapeBorder: shapeBorder ?? CircleBorder(),
        key: globalKey,
        child: child,
        description: description);
  }
}
