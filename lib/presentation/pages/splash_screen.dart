import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/constants/app_routes.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/presentation/blocs/splash_bloc/splash_cubit.dart';
import 'package:story_app/presentation/blocs/splash_bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 2), () {
          if (state.isLogin) {
            context.goNamed(AppRoutes.home.name);
          } else {
            context.goNamed(AppRoutes.login.name);
          }
        });
      },
      child: Scaffold(
        body: Center(
          child: Text(
            AppLocalizations.of(context)!.titleApp,
            style: TextStyles.cok50W800(),
          ),
        ),
      ),
    );
  }
}
