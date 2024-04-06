import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/constants/app_constants.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/utils/extension.dart';
import 'package:story_app/data/models/response/story_data/story_data.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_cubit.dart';
import 'package:story_app/presentation/widgets/cached_image.dart';

class MoreDetailStoryMapsScreen extends StatelessWidget {
  final StoryData storyData;
  const MoreDetailStoryMapsScreen({super.key, required this.storyData});

  @override
  Widget build(BuildContext context) {
    final locale = context.read<LocaleCubit>().state.locale.toLanguageTag();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context)!.detailPost,
          style: TextStyles.pop20W500(
            color: Colors.black,
          ),
        ),
      ),
      body: Hero(
        tag: AppConstants.tagHero.tagDetailStory,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(imgUrl: storyData.photoUrl ?? ""),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: const Row(
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Icon(
                      Icons.reply,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  (storyData.createdAt ?? "").formatDate(locale: locale),
                  style: TextStyles.pop10W400(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: storyData.name ?? "" " ",
                        style: TextStyles.pop14W600(),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(
                        text: storyData.description ?? "",
                        style: TextStyles.pop14W400(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
