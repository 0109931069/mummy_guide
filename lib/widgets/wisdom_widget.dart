import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/utils/globals.dart';

class WisdomeWidget extends StatelessWidget{
  String? imagePath;
  String? wisdom;
  WisdomeWidget({super.key,
  this.imagePath,
  this.wisdom,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        
        
        borderRadius:
            BorderRadius.circular(8.0), // Optional: for rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset:const Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath!,
          ),
          Text(
            wisdom!,
            style: GoogleFonts.reemKufiInk(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Globals.titlecolor
            ),
          )
        ],
      ),
    );
  }
}