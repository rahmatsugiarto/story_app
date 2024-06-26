import 'package:story_app/data/models/app_router.dart';

class AppRoutes {
  const AppRoutes._();

  static AppRouter splashScreen = AppRouter(
    name: "splash_screen",
    path: "/",
  );

  static AppRouter login = AppRouter(
    name: "login",
    path: "/login",
  );

  static AppRouter signUp = AppRouter(
    name: "sign_up",
    path: "sign_up",
  );

  static AppRouter home = AppRouter(
    name: "home",
    path: "/home",
  );

  static AppRouter detailStory = AppRouter(
    name: "detail_story",
    path: "detail_story",
  );

  static AppRouter detailStoryMaps = AppRouter(
    name: "detail_story_maps",
    path: "detail_story_maps",
  );

  static AppRouter moreDetailStoryMaps = AppRouter(
    name: "more_detail_story_maps",
    path: "more_detail_story_maps",
  );

  static AppRouter postStory = AppRouter(
    name: "post_story",
    path: "post_story",
  );

  static AppRouter addLocation = AppRouter(
    name: "add_location",
    path: "add_location",
  );

  static AppRouter camera = AppRouter(
    name: "camera",
    path: "camera",
  );
}
