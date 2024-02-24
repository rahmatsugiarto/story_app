import 'package:flutter/material.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/utils/random_pict.dart';
import 'package:story_app/data/models/response/story_data.dart';
import 'package:story_app/presentation/widgets/cached_image.dart';

class ItemStory extends StatelessWidget {
  final StoryData storyData;

  const ItemStory({
    super.key,
    required this.storyData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 12,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    getRandomPict(),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                storyData.name ?? "",
                style: TextStyles.pop14W600(),
              ),
              const Spacer(),
              const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              )
            ],
          ),
        ),
        CachedImage(
          imgUrl: storyData.photoUrl ?? "",
          height: 360,
        ),
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
            storyData.description ?? "",
            style: TextStyles.pop14W400(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
