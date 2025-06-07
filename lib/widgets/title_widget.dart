import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  String text;

  TitleWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          text,
          textAlign: TextAlign.center,
          textStyle: GoogleFonts.agbalumo(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          colors: [
            const Color(0xFFED2E7C),
            const Color(0xFFFF8EA2),
            const Color(0xFFED2E7C),
          ],
        ),
      ],
      isRepeatingAnimation: true,
      repeatForever: true,
    );
  }
}
