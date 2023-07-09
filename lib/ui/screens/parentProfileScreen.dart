import 'package:exschool/cubits/authCubit.dart';
import 'package:exschool/ui/widgets/customAppbar.dart';
import 'package:exschool/ui/widgets/parentProfileDetailsContainer.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: UiUtils.getScrollViewTopPadding(
                      context: context,
                      appBarHeightPercentage:
                          UiUtils.appBarSmallerHeightPercentage)),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.05),
                  ),
                  ParentProfileDetailsContainer(
                      nameKey: nameKey,
                      parent: context.read<AuthCubit>().getParentDetails())
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
                title: UiUtils.getTranslatedLabel(context, profileKey)),
          ),
        ],
      ),
    );
  }
}
