import 'package:exschool/cubits/assignmentsCubit.dart';
import 'package:exschool/data/models/subject.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//It must be child of AssignmentsCibit
class AssignmentsSubjectContainer extends StatefulWidget {
  final List<Subject> subjects;
  final Function(int) onTapSubject;
  final int selectedSubjectId;

  const AssignmentsSubjectContainer(
      {Key? key,
      required this.subjects,
      required this.onTapSubject,
      required this.selectedSubjectId})
      : super(key: key);

  @override
  State<AssignmentsSubjectContainer> createState() =>
      _AssignmentsSubjectContainerState();
}

class _AssignmentsSubjectContainerState
    extends State<AssignmentsSubjectContainer> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (context.read<AssignmentsCubit>().state
                  is AssignmentsFetchInProgress) {
                return;
              }
              if (widget.subjects[index].id == widget.selectedSubjectId) {
                return;
              }

              final subjectIdIndex = widget.subjects.indexWhere(
                  (element) => widget.subjects[index].id == element.id);

              final selectedSubjectIdIndex = widget.subjects.indexWhere(
                  (element) => widget.selectedSubjectId == element.id);

              _scrollController.animateTo(
                  _scrollController.offset +
                      (subjectIdIndex > selectedSubjectIdIndex ? 1 : -1) *
                          MediaQuery.of(context).size.width *
                          (0.2),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);

              widget.onTapSubject(widget.subjects[index].id);
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(end: 20.0),
              decoration: BoxDecoration(
                  color: widget.selectedSubjectId == widget.subjects[index].id
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text(
                widget.subjects[index].id == 0
                    ? UiUtils.getTranslatedLabel(context, allSubjectsKey)
                    : widget.subjects[index].name,
                style: TextStyle(
                  color: widget.selectedSubjectId == widget.subjects[index].id
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          );
        },
        itemCount: widget.subjects.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * (0.1)),
      ),
    );
  }
}
