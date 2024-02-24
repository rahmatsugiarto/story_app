import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/core/utils/extension.dart';
import 'package:story_app/presentation/blocs/detail_story_bloc/detail_story_cubit.dart';
import 'package:story_app/presentation/blocs/detail_story_bloc/detail_story_state.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_cubit.dart';
import 'package:story_app/presentation/widgets/cached_image.dart';
import 'package:story_app/presentation/widgets/custom_button.dart';
import 'package:story_app/presentation/widgets/skeleton/detail_story_skeleton.dart';

class DetailStoryScreen extends StatefulWidget {
  final String id;
  const DetailStoryScreen({super.key, required this.id});

  @override
  State<DetailStoryScreen> createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchDetailStory();
  }

  void _fetchDetailStory() {
    context.read<DetailStoryCubit>().fetchDetailStory(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DetailStoryCubit, DetailStoryState>(
          builder: (context, state) {
            final status = state.detailState.status;

            if (status.isLoading) {
              return const DetailStorySkeleton();
            } else if (status.isError) {
              final message = state.detailState.message;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Failed',
                          style: TextStyles.pop32W700(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Text(
                            message,
                            style: TextStyles.pop13W400(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    CustomButton(
                      onPressed: () => _fetchDetailStory(),
                      child: Text(
                        "Try Again",
                        style: TextStyles.pop13W400(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (status.isHasData) {
              final data = state.detailState.data?.story;
              final locale =
                  context.read<LocaleCubit>().state.locale.toLanguageTag();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImage(imgUrl: data?.photoUrl ?? ""),
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
                      (data?.createdAt ?? "").formatDate(locale: locale),
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
                            text: data?.name ?? "" " ",
                            style: TextStyles.pop14W600(),
                          ),
                          const TextSpan(text: " "),
                          TextSpan(
                            text: data?.description ?? "",
                            style: TextStyles.pop14W400(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
