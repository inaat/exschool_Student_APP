import 'package:exschool/cubits/authCubit.dart';
import 'package:exschool/ui/widgets/examListContainer.dart';
import 'package:exschool/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/customBackButton.dart';

class ExamContainer extends StatelessWidget {
  final int? childId;

  const ExamContainer({Key? key, this.childId}) : super(key: key);

  //
  Widget _buildAppBar(BuildContext context) {
    return ScreenTopBackgroundContainer(
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          context.read<AuthCubit>().isParent()
              ? CustomBackButton()
              : SizedBox(),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              UiUtils.getTranslatedLabel(context, examsKey),
              style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: UiUtils.screenTitleFontSize),
            ),
          ),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExamListContainer(childId: childId),
        Align(
          alignment: Alignment.topCenter,
          child: _buildAppBar(context),
        ),
      ],
    );
  }
}
