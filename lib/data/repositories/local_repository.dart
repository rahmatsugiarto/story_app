import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';

abstract class LocalRepository {
  Future<void> saveUserData({
    String? token,
    String? userId,
  });
  Future<String> getToken();
  Future<void> saveLocale({
    required String locale,
  });
  Future<String> getLocale();
  Future<void> clearUserData();
}

@LazySingleton(as: LocalRepository)
class LocalRepositoryImpl implements LocalRepository {
  final SharedPreferences sharedPreferences;

  LocalRepositoryImpl({required this.sharedPreferences});

  @override
  Future<void> saveUserData({
    String? token,
    String? userId,
  }) async {
    sharedPreferences.setString(AppConstants.cachedKey.tokenKey, token ?? '');
    sharedPreferences.setString(AppConstants.cachedKey.userIDKey, userId ?? '');
  }

  @override
  Future<String> getToken() async {
    return sharedPreferences.getString(AppConstants.cachedKey.tokenKey) ?? '';
  }

  @override
  Future<void> clearUserData() async {
    sharedPreferences.setString(AppConstants.cachedKey.tokenKey, '');
    sharedPreferences.setString(AppConstants.cachedKey.userIDKey, '');
  }

  @override
  Future<void> saveLocale({
    required String locale,
  }) async {
    sharedPreferences.setString(AppConstants.cachedKey.localeKey, '');
  }

  @override
  Future<String> getLocale() async {
    return sharedPreferences.getString(AppConstants.cachedKey.localeKey) ?? '';
  }
}
