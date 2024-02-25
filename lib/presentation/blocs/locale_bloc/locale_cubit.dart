import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:story_app/core/constants/app_constants.dart';

import '../../../data/repositories/local_repository.dart';
import 'locale_state.dart';

@LazySingleton()
class LocaleCubit extends Cubit<LocaleState> {
  final LocalRepository local;

  LocaleCubit({
    required this.local,
  }) : super(LocaleState(locale: Locale(AppConstants.localeLang.en)));

  void saveLocale({required String locale}) async {
    await local.saveLocale(locale: locale);
    emit(state.copyWith(locale: Locale(locale)));
  }

  void getLocale() async {
    final locale = await local.getLocale();
    emit(state.copyWith(locale: Locale(locale)));
  }
}
