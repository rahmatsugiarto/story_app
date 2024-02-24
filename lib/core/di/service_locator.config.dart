// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../data/repositories/local_repository.dart' as _i9;
import '../../data/repositories/remote_repository.dart' as _i5;
import '../../presentation/blocs/camera_bloc/camera_cubit.dart' as _i3;
import '../../presentation/blocs/detail_story_bloc/detail_story_cubit.dart'
    as _i8;
import '../../presentation/blocs/home_bloc/home_cubit.dart' as _i14;
import '../../presentation/blocs/locale_bloc/locale_cubit.dart' as _i10;
import '../../presentation/blocs/login_bloc/login_cubit.dart' as _i11;
import '../../presentation/blocs/post_bloc/post_cubit.dart' as _i12;
import '../../presentation/blocs/sign_up_bloc/sign_up_cubit.dart' as _i7;
import '../../presentation/blocs/splash_bloc/splash_cubit.dart' as _i13;
import 'register_module.dart' as _i15;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.CameraCubit>(() => _i3.CameraCubit());
  await gh.factoryAsync<_i4.Dio>(
    () => registerModule.dio,
    preResolve: true,
  );
  gh.lazySingleton<_i5.RemoteRepository>(
      () => _i5.RemoteRepositoryImpl(dio: gh<_i4.Dio>()));
  await gh.factoryAsync<_i6.SharedPreferences>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i7.SignUpCubit>(
      () => _i7.SignUpCubit(remote: gh<_i5.RemoteRepository>()));
  gh.lazySingleton<_i8.DetailStoryCubit>(
      () => _i8.DetailStoryCubit(remote: gh<_i5.RemoteRepository>()));
  gh.lazySingleton<_i9.LocalRepository>(() =>
      _i9.LocalRepositoryImpl(sharedPreferences: gh<_i6.SharedPreferences>()));
  gh.lazySingleton<_i10.LocaleCubit>(
      () => _i10.LocaleCubit(local: gh<_i9.LocalRepository>()));
  gh.lazySingleton<_i11.LoginCubit>(() => _i11.LoginCubit(
        remote: gh<_i5.RemoteRepository>(),
        local: gh<_i9.LocalRepository>(),
      ));
  gh.lazySingleton<_i12.PostCubit>(
      () => _i12.PostCubit(remote: gh<_i5.RemoteRepository>()));
  gh.lazySingleton<_i13.SplashCubit>(
      () => _i13.SplashCubit(local: gh<_i9.LocalRepository>()));
  gh.lazySingleton<_i14.HomeCubit>(() => _i14.HomeCubit(
        remote: gh<_i5.RemoteRepository>(),
        local: gh<_i9.LocalRepository>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i15.RegisterModule {}
