import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mamy1/core/constants.dart';
// import 'package:mamy1/core/widgets/space.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/widgets/space.dart';

class PageViewBody extends StatelessWidget{
    const PageViewBody({super.key, this.title, this.description, this.image});
    final String? title;
    final String? description;
    final String? image;
  @override
  Widget build(BuildContext context) {
   
    return Container(
      color: Globals.bgcolor,
      child: Column(
        children: [
          const VerticalSpace(value:  15),
           SizedBox(
            // width: 293,
            height: 44,
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  title!,
                  
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
            ),
          ),
          const VerticalSpace(value: 5),
          Container(
            width: 251.67,
            height: 322,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const VerticalSpace(value: 2),
          SizedBox(
            width: 344,
            child: Text(
              description!,
              textAlign: TextAlign.center,
              style:GoogleFonts.poppins (
                color: const Color(0xFF555555),
                fontSize: 15,
                height: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      
        ],
      ),
    );
  }
}