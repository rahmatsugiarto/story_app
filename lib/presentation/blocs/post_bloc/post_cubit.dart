import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';

import '../../../core/state/view_data_state.dart';
import '../../../data/repositories/remote_repository.dart';
import 'post_state.dart';

@LazySingleton()
class PostCubit extends Cubit<PostState> {
  final RemoteRepository remote;

  PostCubit({
    required this.remote,
  }) : super(PostState(
          postState: ViewData.initial(),
          isReadyToPost: false,
        ));

  void postStory({
    required List<int> bytes,
    required String fileName,
    required String description,
    double? lat,
    double? lon,
  }) async {
    emit(state.copyWith(postState: ViewData.loading()));
    final compressBytes = await _compressImage(bytes);

    final result = await remote.postStory(
      bytes: compressBytes,
      fileName: fileName,
      description: description,
      lat: lat,
      lon: lon,
    );

    result.fold(
      (errorMsg) => emit(
        state.copyWith(
          postState: ViewData.error(message: errorMsg),
        ),
      ),
      (result) => emit(
        state.copyWith(
          postState: ViewData.loaded(data: result),
          isReadyToPost: false,
        ),
      ),
    );
  }

  void setIsReadyToPost({required String desc}) {
    emit(state.copyWith(
      isReadyToPost: desc.isNotEmpty,
      postState: ViewData.initial(),
    ));
  }

  Future<List<int>> _compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
