import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/utils/size_conf.dart';

/// A widget that displays an image and a wisdom text with styling.
class WisdomWidget extends StatelessWidget {
  /// The path to the image asset.
  final String imagePath;

  /// The wisdom text to display.
  final String wisdom;

  /// Creates a WisdomWidget.
  const WisdomWidget({
    super.key,
    required this.imagePath,
    required this.wisdom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize! * 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.02),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 10),
          Text(
            wisdom,
            style: GoogleFonts.reemKufiInk(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Globals.titlecolor,
            ),
          ),
        ],
      ),
    );
  }
}
