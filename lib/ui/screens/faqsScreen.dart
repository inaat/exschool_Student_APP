import 'package:exschool/ui/widgets/customAppbar.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: UiUtils.getScrollViewTopPadding(
                    context: context,
                    appBarHeightPercentage:
                        UiUtils.appBarSmallerHeightPercentage)),
            child: Column(
              children: [Center(child: Text("About us data"))],
            ),
          ),
          CustomAppBar(title: UiUtils.getTranslatedLabel(context, faqsKey))
        ],
      ),
    );
  }
}
