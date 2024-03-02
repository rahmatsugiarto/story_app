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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_fadeController);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.4),
      end: const Offset(0.0, 0.0),
    ).animate(_slideController);

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Text(
                AppLocalizations.of(context)!.titleApp,
                style: TextStyles.cok50W800(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
