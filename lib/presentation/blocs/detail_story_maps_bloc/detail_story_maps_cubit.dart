import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../core/state/view_data_state.dart';
import '../../../data/repositories/remote_repository.dart';
import 'detail_story_maps_state.dart';

@LazySingleton()
class DetailStoryMapsCubit extends Cubit<DetailStoryMapsState> {
  final RemoteRepository remote;

  DetailStoryMapsCubit({
    required this.remote,
  }) : super(DetailStoryMapsState(
          detailState: ViewData.initial(),
          markers: const Marker(markerId: MarkerId("")),
          isShowMore: false,
        ));

  void fetchDetailStory({required String id}) async {
    emit(state.copyWith(detailState: ViewData.loading()));

    final result = await remote.fetchDetailStory(id: id);

    result.fold(
      (errorMsg) => emit(
        state.copyWith(
          detailState: ViewData.error(message: errorMsg),
        ),
      ),
      (result) => emit(
        state.copyWith(
          detailState: ViewData.loaded(data: result),
        ),
      ),
    );
  }

  void setIsShowMore({required bool isShowMore}) {
    emit(state.copyWith(isShowMore: isShowMore));
  }

  void resetState() {
    emit(state.copyWith(
      detailState: ViewData.initial(),
      markers: const Marker(markerId: MarkerId("")),
      isShowMore: false,
    ));
  }

  Future<void> defineMaker({
    required LatLng position,
    required String markerId,
  }) async {
    final info = await geo.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    final marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    emit(state.copyWith(markers: marker));
  }
}
