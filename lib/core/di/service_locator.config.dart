// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../data/repositories/local_repository.dart' as _i11;
import '../../data/repositories/remote_repository.dart' as _i6;
import '../../presentation/blocs/add_location_bloc/add_location_cubit.dart'
    as _i3;
import '../../presentation/blocs/camera_bloc/camera_cubit.dart' as _i4;
import '../../presentation/blocs/detail_story_bloc/detail_story_cubit.dart'
    as _i9;
import '../../presentation/blocs/detail_story_maps_bloc/detail_story_maps_cubit.dart'
    as _i10;
import '../../presentation/blocs/home_bloc/home_cubit.dart' as _i16;
import '../../presentation/blocs/locale_bloc/locale_cubit.dart' as _i12;
import '../../presentation/blocs/login_bloc/login_cubit.dart' as _i13;
import '../../presentation/blocs/post_bloc/post_cubit.dart' as _i14;
import '../../presentation/blocs/sign_up_bloc/sign_up_cubit.dart' as _i8;
import '../../presentation/blocs/splash_bloc/splash_cubit.dart' as _i15;
import 'register_module.dart' as _i17;

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
  gh.lazySingleton<_i3.AddLocationCubit>(() => _i3.AddLocationCubit());
  gh.lazySingleton<_i4.CameraCubit>(() => _i4.CameraCubit());
  await gh.factoryAsync<_i5.Dio>(
    () => registerModule.dio,
    preResolve: true,
  );
  gh.lazySingleton<_i6.RemoteRepository>(
      () => _i6.RemoteRepositoryImpl(dio: gh<_i5.Dio>()));
  await gh.factoryAsync<_i7.SharedPreferences>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.lazySingleton<_i8.SignUpCubit>(
      () => _i8.SignUpCubit(remote: gh<_i6.RemoteRepository>()));
  gh.lazySingleton<_i9.DetailStoryCubit>(
      () => _i9.DetailStoryCubit(remote: gh<_i6.RemoteRepository>()));
  gh.lazySingleton<_i10.DetailStoryMapsCubit>(
      () => _i10.DetailStoryMapsCubit(remote: gh<_i6.RemoteRepository>()));
  gh.lazySingleton<_i11.LocalRepository>(() =>
      _i11.LocalRepositoryImpl(sharedPreferences: gh<_i7.SharedPreferences>()));
  gh.lazySingleton<_i12.LocaleCubit>(
      () => _i12.LocaleCubit(local: gh<_i11.LocalRepository>()));
  gh.lazySingleton<_i13.LoginCubit>(() => _i13.LoginCubit(
        remote: gh<_i6.RemoteRepository>(),
        local: gh<_i11.LocalRepository>(),
      ));
  gh.lazySingleton<_i14.PostCubit>(
      () => _i14.PostCubit(remote: gh<_i6.RemoteRepository>()));
  gh.lazySingleton<_i15.SplashCubit>(
      () => _i15.SplashCubit(local: gh<_i11.LocalRepository>()));
  gh.lazySingleton<_i16.HomeCubit>(() => _i16.HomeCubit(
        remote: gh<_i6.RemoteRepository>(),
        local: gh<_i11.LocalRepository>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i17.RegisterModule {}
