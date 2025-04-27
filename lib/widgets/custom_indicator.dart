import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mummy_guide/utils/globals.dart';
// import 'package:mamy1/core/constants.dart';

class CustomIndicator extends StatelessWidget{
  const CustomIndicator({super.key, @required this.dotindex});
  final double? dotindex;
  @override
  Widget build(BuildContext context) {

   
    return  DotsIndicator(
            animate: true,
            decorator: DotsDecorator(
              color: Colors.white,
              activeColor: Globals.btncolor,
              size: const Size(12.0, 12.0), 
              activeSize: const Size(12.0, 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // side: BorderSide(color: btncolor),
              ),
            ),
            position: dotindex!,
            dotsCount: 4,
    );
  }
}