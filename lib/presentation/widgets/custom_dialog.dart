import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_cubit.dart';
import 'package:story_app/presentation/blocs/locale_bloc/locale_state.dart';
import 'package:story_app/presentation/widgets/item_language.dart';

import '../../core/constants/app_constants.dart';
import 'custom_button.dart';

class CustomDialog {
  static showLogout({
    required void Function()? onLogout,
  }) {
    return SmartDialog.show(
      tag: AppConstants.tagDialog.tagDialog,
      animationType: SmartAnimationType.fade,
      builder: (context) {
        return Container(
          width: 280,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.logout,
                style: TextStyles.pop20W500(),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                AppLocalizations.of(context)!.areYouSureLogout,
                textAlign: TextAlign.center,
                style: TextStyles.pop14W400(),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onLogout,
                      child: Container(
                        height: 40,
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.logout,
                            style: TextStyles.pop14W400(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: CustomButton(
                      onPressed: dismiss,
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyles.pop14W400(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static showLocale() {
    return SmartDialog.show(
      tag: AppConstants.tagDialog.tagDialog,
      animationType: SmartAnimationType.fade,
      builder: (context) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return Container(
              width: 280,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: TextStyles.pop20W500(),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  ItemLanguage(
                    text: AppLocalizations.of(context)!.english,
                    isSelected:
                        state.locale.languageCode == AppConstants.localeLang.en,
                    onTap: () {
                      context.read<LocaleCubit>().saveLocale(
                            locale: AppConstants.localeLang.en,
                          );
                      dismiss();
                    },
                  ),
                  ItemLanguage(
                    text: AppLocalizations.of(context)!.bahasa,
                    isSelected:
                        state.locale.languageCode == AppConstants.localeLang.id,
                    onTap: () {
                      context.read<LocaleCubit>().saveLocale(
                            locale: AppConstants.localeLang.id,
                          );
                      dismiss();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void dismiss() => SmartDialog.dismiss(
        tag: AppConstants.tagDialog.tagDialog,
      );
}
