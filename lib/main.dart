import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/app.dart';
import 'package:story_app/app_bloc_observer.dart';
import 'package:story_app/core/di/service_locator.dart';
import 'package:story_app/core/utils/log.dart';

FutureOr<void> main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        Log.init();
        await configureDependencies();

        FlutterError.onError = (details) {
          Log.e(details.exceptionAsString(), stackTrace: details.stack);
        };

        Bloc.observer = AppBlocObserver();

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );

        runApp(const App());
      },
      (error, stack) {
        Log.f(error.toString(), stackTrace: stack);
      },
    );
