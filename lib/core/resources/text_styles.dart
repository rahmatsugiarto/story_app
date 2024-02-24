import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  TextStyles._();

  static TextStyle pop10W400({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle pop13W400({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle pop14W400({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle pop14W600({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle pop20W500({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle pop32W700({Color color = Colors.black}) {
    return GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle cok36W800({Color color = Colors.black}) {
    return GoogleFonts.cookie(
      fontSize: 36,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }

  static TextStyle cok50W800({Color color = Colors.black}) {
    return GoogleFonts.cookie(
      fontSize: 50,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.normal,
      color: color,
    );
  }
}
