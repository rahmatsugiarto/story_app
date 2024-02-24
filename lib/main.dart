import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:story_app/common.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_cubit.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_state.dart';
import 'package:story_app/presentation/blocs/splash_bloc/splash_cubit.dart';

import 'app_bloc_observer.dart';
import 'core/di/service_locator.dart';
import 'core/utils/log.dart';
import 'router.dart';

void main() => runZonedGuarded(
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

        runApp(const MyApp());
      },
      (error, stack) {
        Log.f(error.toString(), stackTrace: stack);
      },
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SplashCubit>()..getToken(),
        ),
        BlocProvider(
          create: (context) => getIt<LocaleCubit>()..getLocale(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: "Story App",
            builder: FlutterSmartDialog.init(),
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}
