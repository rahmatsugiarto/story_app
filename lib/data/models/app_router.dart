// class AppRouter {
//   final String name;
//   final String path;

//   const AppRouter({required this.name, required this.path});
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_router.freezed.dart';

@freezed
class AppRouter with _$AppRouter {
  factory AppRouter({
    required String name,
    required String path,
  }) = _AppRouter;
}
