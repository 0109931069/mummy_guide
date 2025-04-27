import 'package:flutter/material.dart';
import 'package:mummy_guide/utils/size_conf.dart';

class HorizentalSpace extends StatelessWidget{
  const HorizentalSpace({super.key,@required this.value});

  final double? value; 
  @override
  Widget build(BuildContext context) {
  
    return SizedBox(
            width: SizeConfig.defaultSize! * value!,
          );
  }
}

class VerticalSpace extends StatelessWidget{
  const VerticalSpace({super.key,@required this.value});
  final double? value; 
  @override
  Widget build(BuildContext context) {

    return SizedBox(
            height: SizeConfig.defaultSize! * value!,
          );
  }
}