import 'package:cached_network_image/cached_network_image.dart';
import 'package:exschool/app/routes.dart';
import 'package:exschool/data/models/studyMaterial.dart';
import 'package:exschool/ui/widgets/noDataContainer.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:flutter/material.dart';

class VideosContainer extends StatelessWidget {
  final List<StudyMaterial> studyMaterials;
  VideosContainer({Key? key, required this.studyMaterials}) : super(key: key);

  Widget _buildVideoContainer(
      {required StudyMaterial studyMaterial, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).pushNamed(Routes.playVideo, arguments: {
            "relatedVideos": studyMaterials,
            "currentlyPlayingVideo": studyMaterial
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  offset: Offset(5, 5),
                  blurRadius: 10,
                  spreadRadius: 0)
            ],
          ),
          child: LayoutBuilder(builder: (context, boxConstraints) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              studyMaterial.fileThumbnail)),
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                  height: 65,
                  width: boxConstraints.maxWidth * (0.3),
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * (0.05),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studyMaterial.fileName,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
          width: MediaQuery.of(context).size.width * (0.85),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: studyMaterials.isEmpty
          ? [NoDataContainer(titleKey: noVideosUploadedKey)]
          : studyMaterials
              .map((studyMaterial) => _buildVideoContainer(
                  studyMaterial: studyMaterial, context: context))
              .toList(),
    );
  }
}
