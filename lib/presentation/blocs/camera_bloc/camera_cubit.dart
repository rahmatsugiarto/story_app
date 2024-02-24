import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'camera_state.dart';

@LazySingleton()
class CameraCubit extends Cubit<CameraState> {
  CameraCubit()
      : super(const CameraState(
          isCameraInitialized: false,
          isBackCameraSelected: true,
        ));

  void setIsCameraInitialized({required bool value}) {
    emit(state.copyWith(isCameraInitialized: value));
  }

  void setIsBackCameraSelected({required bool value}) {
    emit(state.copyWith(isBackCameraSelected: value));
  }
}
