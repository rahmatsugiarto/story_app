import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class _DetailStoryMapsScreenState extends State<DetailStoryMapsScreen>
    with SingleTickerProviderStateMixin {
  MapType selectedMapType = MapType.normal;
  Set<Marker> markers = {};

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
    lowerBound: 0.3,
    upperBound: 1.0,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _defineMaker();
    _resetState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    });
  }

  void _setIsShowMore(bool isShowMore) {
    context.read<DetailStoryMapsCubit>().setIsShowMore(isShowMore: isShowMore);
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
                  zoom: 18,
                  target: widget.position,
                ),
                onMapCreated: (controller) {
                  Future.delayed(const Duration(seconds: 2), () {
                    controller.showMarkerInfoWindow(MarkerId(widget.id));
                  });

                  _fetchDetailStory();
                },
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
                  return Container(
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
                              _setIsShowMore(!state.isShowMore);

                              if (state.isShowMore) {
                                _controller.forward();
                              } else {
                                _controller.reverse();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: SizeTransition(
                                sizeFactor: _animation,
                                axis: Axis.vertical,
                                axisAlignment: -1,
                                child: CachedImage(
                                  imgUrl: data?.photoUrl ?? "",
                                ),
                              ),
                            ),
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
                          SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text.rich(
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
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
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
