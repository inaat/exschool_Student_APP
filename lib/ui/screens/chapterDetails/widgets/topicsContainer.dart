import 'package:exschool/app/routes.dart';
import 'package:exschool/data/models/topic.dart';
import 'package:exschool/ui/widgets/noDataContainer.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class TopicsContainer extends StatelessWidget {
  final List<Topic> topics;
  final int? childId;
  const TopicsContainer({Key? key, required this.topics, this.childId})
      : super(key: key);

  Widget _buildTopicDetailsContainer(
      {required Topic topic, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.topicDetails,
              arguments: {"topic": topic, "childId": childId});
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(UiUtils.getTranslatedLabel(context, topicNameKey),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                  textAlign: TextAlign.start),
              SizedBox(
                height: 2.5,
              ),
              Text(topic.name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                  textAlign: TextAlign.start),
              SizedBox(
                height: 15,
              ),
              Text(UiUtils.getTranslatedLabel(context, topicDescriptionKey),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                  textAlign: TextAlign.start),
              SizedBox(
                height: 2.5,
              ),
              Text(topic.description,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                  textAlign: TextAlign.start),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10.0)),
          width: MediaQuery.of(context).size.width * (0.85),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topics.isEmpty
          ? [
              NoDataContainer(
                titleKey: noTopicsKey,
              )
            ]
          : topics
              .map((topic) =>
                  _buildTopicDetailsContainer(topic: topic, context: context))
              .toList(),
    );
  }
}
