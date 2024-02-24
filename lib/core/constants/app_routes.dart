import 'package:story_app/data/models/app_router.dart';

class AppRoutes {
  static const AppRouter splashScreen = AppRouter(
    name: "splash_screen",
    path: "/",
  );

  static const AppRouter login = AppRouter(
    name: "login",
    path: "/login",
  );

  static const AppRouter signUp = AppRouter(
    name: "sign_up",
    path: "sign_up",
  );

  static const AppRouter home = AppRouter(
    name: "home",
    path: "/home",
  );

  static const AppRouter detailStory = AppRouter(
    name: "detail_story",
    path: "detail_story",
  );

  static const AppRouter postStory = AppRouter(
    name: "post_story",
    path: "post_story",
  );

  static const AppRouter camera = AppRouter(
    name: "camera",
    path: "camera",
  );
}
