import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../core/resources/text_styles.dart';

class CustomToast {
  static show({required String message}) => SmartDialog.showToast(
        "",
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyles.pop14W400(
                color: Colors.white,
              ),
            ),
          );
        },
      );

  static showError({required String message}) => SmartDialog.showToast(
        "",
        alignment: Alignment.topCenter,
        displayTime: const Duration(milliseconds: 2000),
        builder: (context) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message,
                style: TextStyles.pop14W400(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );

  static showSuccess({required String message}) => SmartDialog.showToast(
        "",
        alignment: Alignment.topCenter,
        displayTime: const Duration(milliseconds: 3000),
        builder: (context) {
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message,
                style: TextStyles.pop14W400(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );
}
