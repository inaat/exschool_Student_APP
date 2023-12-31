import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exschool/app/routes.dart';
import 'package:exschool/cubits/authCubit.dart';
import 'package:exschool/utils/homeBottomsheetMenu.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoreMenuBottomsheetContainer extends StatelessWidget {
  final Function onTapMoreMenuItemContainer;
  final Function closeBottomMenu;
  const MoreMenuBottomsheetContainer(
      {Key? key,
      required this.onTapMoreMenuItemContainer,
      required this.closeBottomMenu})
      : super(key: key);

  Widget _buildMoreMenuContainer(
      {required BuildContext context,
      required BoxConstraints boxConstraints,
      required String iconUrl,
      required String title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          onTapMoreMenuItemContainer(homeBottomSheetMenu
              .indexWhere((element) => element.title == title));
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.5)),
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.symmetric(
                horizontal: boxConstraints.maxWidth * (0.065),
              ),
              width: boxConstraints.maxWidth * (0.2),
              height: boxConstraints.maxWidth * (0.2),
              padding: EdgeInsets.all(12.5),
              child: SvgPicture.asset(iconUrl),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: boxConstraints.maxWidth * (0.3),
              child: Text(
                UiUtils.getTranslatedLabel(context, title),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.0, right: 25.0, left: 25.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  height: boxConstraints.maxWidth * (0.15),
                  width: boxConstraints.maxWidth * (0.15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(context
                              .read<AuthCubit>()
                              .getStudentDetails()
                              .image)),
                      border: Border.all(
                          width: 2.0,
                          color: Theme.of(context).colorScheme.onBackground),
                      borderRadius: BorderRadius.circular(
                          boxConstraints.maxWidth * (0.11))),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        context
                            .read<AuthCubit>()
                            .getStudentDetails()
                            .getFullName(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0)),
                    Row(
                      children: [
                        Text(
                          "${UiUtils.getTranslatedLabel(context, classKey)} : ${context.read<AuthCubit>().getStudentDetails().classSectionName}",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          width: 1.5,
                          height: 12.0,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "${UiUtils.getTranslatedLabel(context, rollNoKey)} : ${context.read<AuthCubit>().getStudentDetails().rollNumber}",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () async {
                      closeBottomMenu();

                      Navigator.of(context).pushNamed(Routes.studentProfile,
                          arguments:
                              context.read<AuthCubit>().getStudentDetails());
                    },
                    icon: Transform.rotate(
                        angle: pi,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).colorScheme.secondary,
                        )))
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.onBackground,
              height: 50,
            ),
            Wrap(
              children: homeBottomSheetMenu
                  .map((e) => _buildMoreMenuContainer(
                      context: context,
                      boxConstraints: boxConstraints,
                      iconUrl: e.iconUrl,
                      title: e.title))
                  .toList(),
            ),
            SizedBox(
              height: UiUtils.getScrollViewBottomPadding(context),
            ),
          ],
        );
      }),
    );
  }
}
