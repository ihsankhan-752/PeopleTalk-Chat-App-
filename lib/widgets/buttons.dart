import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  const PrimaryButton({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 12.0,
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.PRIMARY_BLACK,
          ),
          child: Center(
            child: Text(
              '$title',
              style: GoogleFonts.acme(
                fontSize: 16,
                color: AppColors.PRIMARY_WHITE,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
