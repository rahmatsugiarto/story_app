import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/core/constants/app_constants.dart';
import 'package:story_app/core/constants/app_routes.dart';
import 'package:story_app/core/utils/log.dart';
import 'package:story_app/presentation/blocs/camera_bloc/camera_cubit.dart';
import 'package:story_app/presentation/blocs/camera_bloc/camera_state.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _setIsCameraInitialized(false);
    _onNewCameraSelected(widget.cameras.first);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      _onNewCameraSelected(cameraController.description);
    }
  }

  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    await previousCameraController?.dispose();

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      Log.e('Error initializing camera: $e');
    }

    if (mounted) {
      controller = cameraController;
      _setIsCameraInitialized(controller!.value.isInitialized);
    }
  }

  Future<void> _onCameraButtonClick() async {
    await controller?.takePicture().then((value) {
      context.goNamed(AppRoutes.postStory.name, extra: value);
    });
  }

  void _onCameraSwitch() {
    if (widget.cameras.length == 1) return;

    _setIsCameraInitialized(false);

    final isBackCameraSelected =
        context.read<CameraCubit>().state.isBackCameraSelected;
    _onNewCameraSelected(
      widget.cameras[isBackCameraSelected ? 1 : 0],
    );

    _setIsBackCameraSelected(!isBackCameraSelected);
  }

  void _onPickImage() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;
    final picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        context.goNamed(
          AppRoutes.postStory.name,
          extra: value,
        );
      }
    });
  }

  void _setIsCameraInitialized(bool value) {
    context.read<CameraCubit>().setIsCameraInitialized(value: value);
  }

  void _setIsBackCameraSelected(bool value) {
    context.read<CameraCubit>().setIsBackCameraSelected(value: value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<CameraCubit, CameraState>(
              builder: (context, state) {
                if (state.isCameraInitialized) {
                  return Hero(
                    tag: AppConstants.tagHero.tagLocale,
                    child: CameraPreview(
                      controller!,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: _onPickImage,
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      onPressed: () => _onCameraButtonClick(),
                      child: const Icon(Icons.camera_alt),
                    ),
                    IconButton(
                      onPressed: () => _onCameraSwitch(),
                      icon: const Icon(
                        Icons.cameraswitch,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    onPressed: () => context.pop(),
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
