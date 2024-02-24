import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/constants/app_constants.dart';

class CustomDialogLoading {
  static void show() => SmartDialog.show(
        keepSingle: true,
        clickMaskDismiss: false,
        animationType: SmartAnimationType.fade,
        tag: AppConstants.tagDialog.tagDialogLoading,
        builder: (context) {
          return Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const SpinKitFoldingCube(
              color: Colors.black,
              size: 30,
            ),
          );
        },
      );

  static void dismiss() => SmartDialog.dismiss(
        tag: AppConstants.tagDialog.tagDialogLoading,
      );
}
