import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DecoratedText extends StatelessWidget {
  final String? title;
  const DecoratedText({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            title!,
            textStyle: GoogleFonts.acme(
              fontSize: 16,
            ),
            colors: [
              Colors.purple,
              Colors.pink,
            ],
          ),
        ],
      ),
    );
  }
}
