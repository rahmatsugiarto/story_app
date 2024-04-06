import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  factory CameraState({
    required bool isCameraInitialized,
    required bool isBackCameraSelected,
  }) = _CameraState;
}
