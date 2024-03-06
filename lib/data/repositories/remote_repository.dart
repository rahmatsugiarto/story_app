import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:story_app/data/models/request/login_request/login_request.dart';
import 'package:story_app/data/models/request/sign_up_request/sign_up_request.dart';
import 'package:story_app/data/models/request/story_request/story_request.dart';
import 'package:story_app/data/models/response/detail_story_response/detail_story_response.dart';
import 'package:story_app/data/models/response/login_response/login_response.dart';
import 'package:story_app/data/models/response/post_story_response/post_story_response.dart';
import 'package:story_app/data/models/response/sign_up_response/sign_up_response.dart';
import 'package:story_app/data/models/response/story_response/story_response.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/extension.dart';

abstract class RemoteRepository {
  Future<Either<String, LoginResponse>> authLogin({
    required String email,
    required String pass,
  });

  Future<Either<String, SignUpResponse>> authSignUp({
    required String name,
    required String email,
    required String pass,
  });

  Future<Either<String, StoryResponse>> fetchListStory({
    required int page,
    required int location,
  });

  Future<Either<String, DetailStoryResponse>> fetchDetailStory({
    required String id,
  });

  Future<Either<String, PostStoryResponse>> postStory({
    required List<int> bytes,
    required String fileName,
    required String description,
    double? lat,
    double? lon,
  });
}

@LazySingleton(as: RemoteRepository)
class RemoteRepositoryImpl implements RemoteRepository {
  final Dio dio;

  const RemoteRepositoryImpl({required this.dio});

  @override
  Future<Either<String, LoginResponse>> authLogin({
    required String email,
    required String pass,
  }) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.login,
        data: LoginRequest(email: email, password: pass).toJson(),
      );

      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (error) {
      if (error.isNoConnectionError) {
        return Left(AppConstants.errorMessage.noInternet);
      }
      return Left(error.response?.data[AppConstants.errorKey.message]);
    } catch (e) {
      return Left(AppConstants.errorMessage.errorCommon);
    }
  }

  @override
  Future<Either<String, SignUpResponse>> authSignUp({
    required String name,
    required String email,
    required String pass,
  }) async {
    try {
      final response = await dio.post(
        AppConstants.appApi.register,
        data: SignUpRequest(
          name: name,
          email: email,
          password: pass,
        ).toJson(),
      );

      return Right(SignUpResponse.fromJson(response.data));
    } on DioException catch (error) {
      if (error.isNoConnectionError) {
        return Left(AppConstants.errorMessage.noInternet);
      }
      return Left(error.response?.data[AppConstants.errorKey.message]);
    } catch (e) {
      return Left(AppConstants.errorMessage.errorCommon);
    }
  }

  @override
  Future<Either<String, StoryResponse>> fetchListStory({
    required int page,

    /// 1 for get all stories with location
    /// 0 for all stories without considering location
    required int location,
  }) async {
    try {
      final response = await dio.get(
        AppConstants.appApi.stories,
        queryParameters: StoryRequest(
          page: page,
          size: 10,
          location: location,
        ).toJson(),
      );

      return Right(StoryResponse.fromJson(response.data));
    } on DioException catch (error) {
      if (error.isNoConnectionError) {
        return Left(AppConstants.errorMessage.noInternet);
      }
      return Left(error.response?.data[AppConstants.errorKey.message]);
    } catch (e) {
      return Left(AppConstants.errorMessage.errorCommon);
    }
  }

  @override
  Future<Either<String, DetailStoryResponse>> fetchDetailStory({
    required String id,
  }) async {
    try {
      final response = await dio.get("${AppConstants.appApi.stories}/$id");

      return Right(DetailStoryResponse.fromJson(response.data));
    } on DioException catch (error) {
      if (error.isNoConnectionError) {
        return Left(AppConstants.errorMessage.noInternet);
      }
      return Left(error.response?.data[AppConstants.errorKey.message]);
    } catch (e) {
      return Left(AppConstants.errorMessage.errorCommon);
    }
  }

  @override
  Future<Either<String, PostStoryResponse>> postStory({
    required List<int> bytes,
    required String fileName,
    required String description,
    double? lat,
    double? lon,
  }) async {
    try {
      final file = MultipartFile.fromBytes(
        bytes,
        filename: fileName,
      );

      final formData = lat == null || lon == null
          ? FormData.fromMap({
              "description": description,
              "photo": file,
            })
          : FormData.fromMap({
              "description": description,
              "photo": file,
              "lat": lat,
              "lon": lon,
            });

      final response = await dio.post(
        AppConstants.appApi.stories, data: formData,
        // data: {
        //   "description": description,
        //   "photo": file,
        //   "lat": lat,
        //   "lon": lon,
        // },
      );

      return Right(PostStoryResponse.fromJson(response.data));
    } on DioException catch (error) {
      if (error.isNoConnectionError) {
        return Left(AppConstants.errorMessage.noInternet);
      }
      return Left(error.response?.data[AppConstants.errorKey.message]);
    } catch (e) {
      return Left(AppConstants.errorMessage.errorCommon);
    }
  }
}
