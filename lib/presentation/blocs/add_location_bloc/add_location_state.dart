import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'add_location_state.freezed.dart';

@freezed
class AddLocationState with _$AddLocationState {
  factory AddLocationState({
    required Marker markers,
    geo.Placemark? placemark,
  }) = _AddLocationState;
}
