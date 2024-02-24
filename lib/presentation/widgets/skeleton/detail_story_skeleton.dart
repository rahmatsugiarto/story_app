import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:story_app/core/resources/text_styles.dart';

class DetailStorySkeleton extends StatelessWidget {
  const DetailStorySkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.bones(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Bone(
            height: 360,
            width: MediaQuery.sizeOf(context).width,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: const Row(
              children: [
                Bone.icon(),
                SizedBox(
                  width: 12.0,
                ),
                Bone.icon(),
                SizedBox(
                  width: 12.0,
                ),
                Bone.icon(),
                Spacer(),
                Bone.icon(),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(
                  words: 1,
                  style: TextStyles.pop10W400(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Bone.text(
                  width: MediaQuery.sizeOf(context).width,
                  style: TextStyles.pop14W400(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Bone.text(
                  width: MediaQuery.sizeOf(context).width,
                  style: TextStyles.pop14W400(),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Bone.text(
                  width: MediaQuery.sizeOf(context).width,
                  style: TextStyles.pop14W400(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
