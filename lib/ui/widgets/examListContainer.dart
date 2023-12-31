import 'package:exschool/app/routes.dart';
import 'package:exschool/cubits/authCubit.dart';
import 'package:exschool/cubits/examCubit.dart';
import 'package:exschool/data/models/exam.dart';
import 'package:exschool/ui/widgets/customRefreshIndicator.dart';
import 'package:exschool/ui/widgets/customShimmerContainer.dart';
import 'package:exschool/ui/widgets/errorContainer.dart';
import 'package:exschool/ui/widgets/examsFilterContainer.dart';
import 'package:exschool/ui/widgets/listItemForExamAndResult.dart';
import 'package:exschool/ui/widgets/noDataContainer.dart';
import 'package:exschool/ui/widgets/shimmerLoadingContainer.dart';
import 'package:exschool/utils/constants.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamListContainer extends StatefulWidget {
  final int? childId;

  ExamListContainer({Key? key, this.childId}) : super(key: key);

  @override
  State<ExamListContainer> createState() => _ExamListContainerState();
}

class _ExamListContainerState extends State<ExamListContainer> {
  String _currentlySelectedExamFilter = allExamsKey;

  @override
  void initState() {
    super.initState();
    fetchExamsList();
  }

  void fetchExamsList() {
    Future.delayed(Duration.zero, () {
      //
      //Exam status: 0- All exam, 1-Upcoming, 2-Ongoing, 3-Completed
      context.read<ExamDetailsCubit>().fetchStudentExamsList(
          useParentApi: context.read<AuthCubit>().isParent(),
          childId: widget.childId,
          examStatus: 0);
    });
  }

  Widget _buildExamList(List<Exam> examList) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                examList.length,
                (index) => ListItemForExamAndResult(
                    examStartingDate: examList[index].examStartingDate!,
                    examName: examList[index].examName!,
                    resultPercentage: 0,
                    resultGrade: '',
                    onItemTap: () {
                      //if examStartingDate is empty then there is no exam timetable
                      if (examList[index].examStartingDate! == '') {
                        UiUtils.showCustomSnackBar(
                            context: context,
                            errorMessage: UiUtils.getTranslatedLabel(
                                context, noExamTimeTableFoundKey),
                            backgroundColor:
                                Theme.of(context).colorScheme.error);
                        return;
                      }
                      Navigator.of(context)
                          .pushNamed(Routes.examTimeTable, arguments: {
                        'examID': examList[index].examID,
                        'examName': examList[index].examName.toString(),
                        'childID': widget.childId
                      });
                    }))),
      ),
    );
  }

  Widget _buildExamShimmerLoadingContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: UiUtils.screenContentHorizontalPaddingInPercentage *
              MediaQuery.of(context).size.width),
      child: ShimmerLoadingContainer(
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoadingContainer(
                  child: CustomShimmerContainer(
                height: 9,
                width: boxConstraints.maxWidth * (0.3),
              )),
              SizedBox(
                height: boxConstraints.maxWidth * (0.02),
              ),
              ShimmerLoadingContainer(
                  child: CustomShimmerContainer(
                height: 10,
                width: boxConstraints.maxWidth * (0.8),
              )),
              SizedBox(
                height: boxConstraints.maxWidth * (0.1),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildExamLoading() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(UiUtils.defaultShimmerLoadingContentCount,
                (index) => _buildExamShimmerLoadingContainer()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: UiUtils.getScrollViewBottomPadding(context),
            top: UiUtils.getScrollViewTopPadding(
                context: context,
                appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage)),
        child: Column(
          children: [
            //Filter
            ExamFiltersContainer(
              onTapSubject: (examFilterIndex) {
                //
                //Exam status: 0-All exam, 1-Upcoming, 2-Ongoing, 3-Completed
                context.read<ExamDetailsCubit>().fetchStudentExamsList(
                    useParentApi: context.read<AuthCubit>().isParent(),
                    childId: widget.childId,
                    examStatus:
                        examFilters.indexOf(examFilters[examFilterIndex]));

                setState(() {
                  _currentlySelectedExamFilter = examFilters[examFilterIndex];
                });
              },
              selectedExamFilterIndex:
                  examFilters.indexOf(_currentlySelectedExamFilter),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (0.035),
            ),
            BlocBuilder<ExamDetailsCubit, ExamDetailsState>(
              builder: (context, state) {
                if (state is ExamDetailsFetchSuccess) {
                  return Align(
                      alignment: Alignment.topCenter,
                      child: state.examList.isEmpty
                          ? NoDataContainer(titleKey: noExamsFoundKey)
                          : _buildExamList(state.examList));
                }
                if (state is ExamDetailsFetchFailure) {
                  return ErrorContainer(
                    errorMessageCode: state.errorMessage,
                    onTapRetry: () {
                      context.read<ExamDetailsCubit>().fetchStudentExamsList(
                          useParentApi: context.read<AuthCubit>().isParent(),
                          childId: widget.childId,
                          examStatus: examFilters
                              .indexOf(_currentlySelectedExamFilter));
                    },
                  );
                }

                return _buildExamLoading();
              },
            ),
          ],
        ),
      ),
      displacment: UiUtils.getScrollViewTopPadding(
          context: context,
          appBarHeightPercentage: UiUtils.appBarBiggerHeightPercentage),
      onRefreshCallback: () {
        //
        //Exam status: 0- All exam, 1-Upcoming, 2-Ongoing, 3-Completed
        int examStatus = examFilters.indexOf(_currentlySelectedExamFilter);
        context.read<ExamDetailsCubit>().fetchStudentExamsList(
            examStatus: examStatus,
            useParentApi: context.read<AuthCubit>().isParent(),
            childId: widget.childId);
      },
    );
  }
}
