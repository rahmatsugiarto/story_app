import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/constants/app_constants.dart';
import 'package:story_app/core/di/service_locator.dart';
import 'package:story_app/presentation/blocs/camera_bloc/camera_cubit.dart';
import 'package:story_app/presentation/blocs/detail_story_bloc/detail_story_cubit.dart';
import 'package:story_app/presentation/blocs/home_bloc/home_cubit.dart';
import 'package:story_app/presentation/blocs/login_bloc/login_cubit.dart';
import 'package:story_app/presentation/blocs/post_bloc/post_cubit.dart';
import 'package:story_app/presentation/blocs/sign_up_bloc/sign_up_cubit.dart';
import 'package:story_app/presentation/pages/camera_screen.dart';
import 'package:story_app/presentation/pages/login_screen.dart';
import 'package:story_app/presentation/pages/post_story_screen.dart';
import 'package:story_app/presentation/pages/sign_up_screen.dart';
import 'package:story_app/presentation/pages/splash_screen.dart';

import 'core/constants/app_routes.dart';
import 'presentation/pages/detail_story_screen.dart';
import 'presentation/pages/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splashScreen.path,
  debugLogDiagnostics: true,
  observers: [FlutterSmartDialog.observer],
  routerNeglect: true,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen.path,
      name: AppRoutes.splashScreen.name,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.login.path,
      name: AppRoutes.login.name,
      builder: (context, state) {
        return BlocProvider.value(
          value: getIt<LoginCubit>(),
          child: const LoginScreen(),
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.signUp.path,
          name: AppRoutes.signUp.name,
          builder: (context, state) {
            return BlocProvider.value(
              value: getIt<SignUpCubit>(),
              child: const SignUpScreen(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      builder: (context, state) {
        return BlocProvider.value(
          value: getIt<HomeCubit>(),
          child: const HomeScreen(),
        );
      },
      routes: [
        GoRoute(
          path: "${AppRoutes.detailStory.path}/:${AppConstants.argsKey.id}",
          name: AppRoutes.detailStory.name,
          builder: (context, state) {
            final id = state.pathParameters[AppConstants.argsKey.id];

            return BlocProvider.value(
              value: getIt<DetailStoryCubit>(),
              child: DetailStoryScreen(id: id ?? ""),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.camera.path,
          name: AppRoutes.camera.name,
          builder: (context, state) {
            List<CameraDescription> cameras =
                state.extra as List<CameraDescription>;

            return BlocProvider.value(
              value: getIt<CameraCubit>(),
              child: CameraScreen(cameras: cameras),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.postStory.path,
          name: AppRoutes.postStory.name,
          builder: (context, state) {
            XFile file = state.extra as XFile;

            return BlocProvider.value(
              value: getIt<PostCubit>(),
              child: PostStoryScreen(file: file),
            );
          },
        ),
      ],
    ),
  ],
);
