import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/constants/app_constants.dart';
import 'package:story_app/core/constants/app_routes.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/core/utils/extension.dart';
import 'package:story_app/presentation/blocs/detail_story_maps_bloc/detail_story_maps_cubit.dart';
import 'package:story_app/presentation/blocs/detail_story_maps_bloc/detail_story_maps_state.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_cubit.dart';
import 'package:story_app/presentation/widgets/cached_image.dart';
import 'package:story_app/presentation/widgets/custom_dialog_loading.dart';
import 'package:story_app/presentation/widgets/custom_toast.dart';

class DetailStoryMapsScreen extends StatefulWidget {
  final String id;
  final LatLng position;

  const DetailStoryMapsScreen({
    super.key,
    required this.id,
    required this.position,
  });

  @override
  State<DetailStoryMapsScreen> createState() => _DetailStoryMapsScreenState();
}

class _DetailStoryMapsScreenState extends State<DetailStoryMapsScreen> {
  MapType selectedMapType = MapType.normal;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _fetchDetailStory() {
    context.read<DetailStoryMapsCubit>().fetchDetailStory(id: widget.id);
  }

  void _resetState() {
    context.read<DetailStoryMapsCubit>().resetState();
  }

  void _defineMaker() async {
    await context
        .read<DetailStoryMapsCubit>()
        .defineMaker(
          position: widget.position,
          markerId: widget.id,
        )
        .then((_) {
      markers.add(context.read<DetailStoryMapsCubit>().state.markers);
      _fetchDetailStory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlocBuilder<DetailStoryMapsCubit, DetailStoryMapsState>(
            builder: (context, state) {
              return GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  zoom: 16,
                  target: widget.position,
                ),
                onMapCreated: (_) => _defineMaker(),
              );
            },
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocConsumer<DetailStoryMapsCubit, DetailStoryMapsState>(
              listener: (context, state) {
                final status = state.detailState.status;
                final message = state.detailState.message;

                if (status.isLoading) {
                  CustomDialogLoading.show();
                }

                if (status.isError) {
                  CustomDialogLoading.dismiss();
                  CustomToast.showError(message: message);
                }

                if (status.isHasData) {
                  CustomDialogLoading.dismiss();
                }
              },
              builder: (context, state) {
                final status = state.detailState.status;
                final data = state.detailState.data?.story;
                final locale =
                    context.read<LocaleCubit>().state.locale.toLanguageTag();

                if (status.isHasData) {
                  return Hero(
                    tag: AppConstants.tagHero.tagDetailStory,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.moreDetailStoryMaps.name,
                                  extra: data,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: CachedImage(
                                  imgUrl: data?.photoUrl ?? "",
                                  height: 170,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                (data?.createdAt ?? "")
                                    .formatDate(locale: locale),
                                style: TextStyles.pop10W400(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: AutoSizeText.rich(
                                  maxLines: 2,
                                  overflowReplacement: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text.rich(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: data?.name ?? "",
                                              style: TextStyles.pop14W600(),
                                            ),
                                            const TextSpan(text: " "),
                                            TextSpan(
                                              text: data?.description ?? "",
                                              style: TextStyles.pop14W400(),
                                            ),
                                            const TextSpan(text: " "),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                            AppRoutes.moreDetailStoryMaps.name,
                                            extra: data,
                                          );
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .readMore,
                                          style: TextStyles.pop14W600(
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: data?.name ?? "",
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
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
