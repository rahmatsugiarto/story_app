import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import 'add_location_state.dart';

@LazySingleton()
class AddLocationCubit extends Cubit<AddLocationState> {
  AddLocationCubit()
      : super(AddLocationState(
          markers: const Marker(markerId: MarkerId("")),
          placemark: null,
        ));

  Future<void> defineMaker({
    required LatLng position,
    required String street,
    required String address,
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
      markerId: const MarkerId("markerId"),
      position: position,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    emit(state.copyWith(markers: marker));
  }

  void setPlacemark({Placemark? placemark}) async {
    emit(state.copyWith(placemark: placemark));
  }
}
