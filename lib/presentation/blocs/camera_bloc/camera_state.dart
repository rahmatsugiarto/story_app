class CameraState {
  final bool isCameraInitialized;
  final bool isBackCameraSelected;

  const CameraState({
    required this.isCameraInitialized,
    required this.isBackCameraSelected,
  });

  CameraState copyWith({
    bool? isCameraInitialized,
    bool? isBackCameraSelected,
  }) {
    return CameraState(
      isCameraInitialized: isCameraInitialized ?? this.isCameraInitialized,
      isBackCameraSelected: isBackCameraSelected ?? this.isBackCameraSelected,
    );
  }
}
