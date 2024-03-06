import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/utils/log.dart';
import 'package:story_app/presentation/blocs/add_location_bloc/add_location_cubit.dart';
import 'package:story_app/presentation/blocs/add_location_bloc/add_location_state.dart';
import 'package:story_app/presentation/widgets/custom_button.dart';
import 'package:story_app/presentation/widgets/custom_dialog_loading.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  late GoogleMapController _mapController;
  late final Set<Marker> _markers = {};
  LatLng? _location;

  @override
  void initState() {
    super.initState();
    _onMyLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _setPlacemark(geo.Placemark? placemark) {
    context.read<AddLocationCubit>().setPlacemark(placemark: placemark);
  }

  void _onMyLocation() async {
    CustomDialogLoading.show();

    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Log.i("Location services is not available");
        CustomDialogLoading.dismiss();
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Log.i("Location permission is denied");
        CustomDialogLoading.dismiss();
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street ?? "";
    final address =
        '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';

    _setPlacemark(place);

    _defineMarker(
      latLng: latLng,
      street: street,
      address: address,
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );

    CustomDialogLoading.dismiss();
  }

  void _defineMarker({
    required LatLng latLng,
    required String street,
    required String address,
  }) {
    context.read<AddLocationCubit>().defineMaker(
          position: latLng,
          street: street,
          address: address,
        );

    _location = latLng;
  }

  void _onTapGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';

    _setPlacemark(place);
    _defineMarker(
      latLng: latLng,
      street: street,
      address: address,
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            BlocBuilder<AddLocationCubit, AddLocationState>(
              builder: (context, state) {
                _markers.clear();
                _markers.add(context.read<AddLocationCubit>().state.markers);

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    zoom: 18,
                    target: _dicodingOffice,
                  ),
                  markers: _markers,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  onTap: _onTapGoogleMap,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                );
              },
            ),
            BlocBuilder<AddLocationCubit, AddLocationState>(
              builder: (context, state) {
                if (state.placemark != null) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 20,
                            bottom: 20,
                          ),
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: _onMyLocation,
                            child: const Icon(Icons.my_location),
                          ),
                        ),
                        PlacemarkWidget(
                          placemark: state.placemark!,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                            bottom: 20,
                          ),
                          child: CustomButton(
                            width: MediaQuery.sizeOf(context).width,
                            onPressed: () {
                              context.pop(_location);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.addLocation,
                              style: TextStyles.pop14W400(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
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
            ),
          ],
        ),
      ),
    );
  }
}

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
  });
  final geo.Placemark placemark;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  placemark.street ?? "",
                  style: TextStyles.pop20W500(),
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}',
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
