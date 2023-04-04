import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyle {
  TextStyle DECORATED_TEXT_STYLE = GoogleFonts.acme(
    fontSize: 18,
  );
  TextStyle BASIC_STYLE = GoogleFonts.acme(
    fontSize: 16,
    color: AppColors.PRIMARY_BLACK,
  );
  TextStyle AUTH_HEADER = TextStyle(
    fontSize: 18,
    color: AppColors.PRIMARY_BLACK,
    fontWeight: FontWeight.w700,
  );
}
