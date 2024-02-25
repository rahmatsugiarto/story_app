import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:story_app/core/utils/log.dart';

extension DioErrorX on DioException {
  bool get isNoConnectionError {
    return type == DioExceptionType.connectionError && error is SocketException;
  }
}

extension DateFormatting on String {
  String formatDate({String format = 'dd MMMM yyyy', String locale = 'id'}) {
    try {
      initializeDateFormatting(locale);
      final dateTime = DateTime.parse(this);
      final formatter = DateFormat(format, locale);

      return formatter.format(dateTime);
    } catch (e) {
      Log.e(e.toString());
      return e.toString();
    }
  }
}
