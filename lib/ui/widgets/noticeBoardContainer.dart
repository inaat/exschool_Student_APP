import 'package:exschool/cubits/authCubit.dart';
import 'package:exschool/cubits/noticeBoardCubit.dart';
import 'package:exschool/data/models/announcement.dart';
import 'package:exschool/ui/widgets/announcementDetailsContainer.dart';
import 'package:exschool/ui/widgets/customBackButton.dart';
import 'package:exschool/ui/widgets/customRefreshIndicator.dart';
import 'package:exschool/ui/widgets/errorContainer.dart';
import 'package:exschool/ui/widgets/noDataContainer.dart';
import 'package:exschool/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:exschool/ui/widgets/shimmerLoaders/announcementShimmerLoadingContainer.dart';

import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoticeBoardContainer extends StatefulWidget {
  final bool showBackButton;
  NoticeBoardContainer({Key? key, required this.showBackButton})
      : super(key: key);

  @override
  State<NoticeBoardContainer> createState() => _NoticeBoardContainerState();
}

class _NoticeBoardContainerState extends State<NoticeBoardContainer> {
  late ScrollController _scrollController = ScrollController()
    ..addListener(_noticeBoardScrollListener);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<NoticeBoardCubit>().fetchNoticeBoardDetails(
            useParentApi: context.read<AuthCubit>().isParent(),
          );
    });
  }

  void _noticeBoardScrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      if (context.read<NoticeBoardCubit>().hasMore()) {
        context.read<NoticeBoardCubit>().fetchMoreAnnouncements(
              useParentApi: context.read<AuthCubit>().isParent(),
            );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_noticeBoardScrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildAppBar() {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.all(0),
      child: Stack(
        children: [
          widget.showBackButton
              ? CustomBackButton(
                  alignmentDirectional: AlignmentDirectional.centerStart,
                )
              : SizedBox(),
          Align(
            alignment: Alignment.center,
            child: Text(
              UiUtils.getTranslatedLabel(context, noticeBoardKey),
              style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: UiUtils.screenTitleFontSize),
            ),
          ),
        ],
      ),
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
    );
  }

  Widget _buildNoticeContainer(
      {required Announcement noticeBoardAnnouncement,
      required int index,
      required int totalAnnouncements,
      required bool hasMoreAnnouncements,
      required bool hasMoreAnnouncementsInProgress,
      required bool fetchMoreAnnouncementsFailure}) {
    //show announcement loading container for last announcement container
    if (index == (totalAnnouncements - 1)) {
      //If has more assignment
      if (hasMoreAnnouncements) {
        if (hasMoreAnnouncementsInProgress) {
          return AnnouncementShimmerLoadingContainer();
        }
        if (fetchMoreAnnouncementsFailure) {
          return Center(
            child: CupertinoButton(
                child: Text(UiUtils.getTranslatedLabel(context, retryKey)),
                onPressed: () {
                  context.read<NoticeBoardCubit>().fetchMoreAnnouncements(
                        useParentApi: context.read<AuthCubit>().isParent(),
                      );
                }),
          );
        }
      }
    }

    return AnnouncementDetailsContainer(announcement: noticeBoardAnnouncement);
  }

  Widget _buildNoticeBoardContainer() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomRefreshIndicator(
        onRefreshCallback: () {
          if (context.read<NoticeBoardCubit>().state
              is NoticeBoardFetchSuccess) {
            context.read<NoticeBoardCubit>().fetchNoticeBoardDetails(
                  useParentApi: context.read<AuthCubit>().isParent(),
                );
          }
        },
        displacment: UiUtils.getScrollViewTopPadding(
            context: context,
            appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
              bottom: widget.showBackButton
                  ? 0
                  : UiUtils.getScrollViewBottomPadding(context),
              top: UiUtils.getScrollViewTopPadding(
                  context: context,
                  appBarHeightPercentage:
                      UiUtils.appBarSmallerHeightPercentage)),
          child: BlocBuilder<NoticeBoardCubit, NoticeBoardState>(
            builder: (context, state) {
              if (state is NoticeBoardFetchSuccess) {
                return state.announcements.isEmpty
                    ? NoDataContainer(titleKey: noticeBoardEmptyKey)
                    : Column(
                        children: List.generate(
                                state.announcements.length, (index) => index)
                            .map((index) => _buildNoticeContainer(
                                noticeBoardAnnouncement:
                                    state.announcements[index],
                                index: index,
                                totalAnnouncements: state.announcements.length,
                                hasMoreAnnouncements:
                                    context.read<NoticeBoardCubit>().hasMore(),
                                hasMoreAnnouncementsInProgress:
                                    state.fetchMoreAnnouncementsInProgress,
                                fetchMoreAnnouncementsFailure:
                                    state.moreAnnouncementsFetchError))
                            .toList(),
                      );
              }
              if (state is NoticeBoardFetchFailure) {
                return Center(
                  child: ErrorContainer(
                    errorMessageCode: state.errorMessage,
                    onTapRetry: () {
                      context.read<NoticeBoardCubit>().fetchNoticeBoardDetails(
                            useParentApi: context.read<AuthCubit>().isParent(),
                          );
                    },
                  ),
                );
              }

              return Column(
                children: List.generate(
                        UiUtils.defaultShimmerLoadingContentCount,
                        (index) => index)
                    .map((e) => AnnouncementShimmerLoadingContainer())
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildNoticeBoardContainer(),
        Align(
          alignment: Alignment.topCenter,
          child: _buildAppBar(),
        ),
      ],
    );
  }
}
