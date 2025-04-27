import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mummy_guide/utils/globals.dart';
// import 'package:mummy_guide/core/widgets/custom_buttons.dart';

import '../../../../../main.dart';
// import 'package:mummy_guide/screens/authentication/login_screen.dart';
import 'package:mummy_guide/widgets/custom_page_view.dart';
import 'package:mummy_guide/widgets/custom_indicator.dart';
// import 'package:mummy_guide/widgets/page_view_body.dart';
import 'package:mummy_guide/utils/size_conf.dart';

class OnboardingScreen extends StatefulWidget {
  
  const OnboardingScreen({super.key});


  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  
  @override
  void initState() {
    pageController = PageController(
      initialPage: 3,
    )..addListener(() {
        setState(() {});
      });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(
          pagecontroller: pageController,
        ),
        Positioned(
          bottom: SizeConfig.defaultSize! * 15,
          left: 0,
          right: 0,
          child: CustomIndicator(
            dotindex: pageController!.hasClients ? pageController!.page : 3,
          ),
        ),
        Positioned(
          top: SizeConfig.defaultSize! * 7,
          right: 32,
          child: TextButton(
            onPressed: () {
              // Navigate to the next screen
              // Navigator.of(context).pushReplacementNamed('/nextScreen');
              Navigator.of(context).pushNamed("/login");
            },
            child: Text(
              'Skip',
              style: GoogleFonts.poppins(
                color: const Color(0xFFED2E7C),
                fontSize: 15,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: SizeConfig.defaultSize! * 5,
          left: SizeConfig.defaultSize! * 10,
          right: SizeConfig.defaultSize! * 10,
          child: FilledButton(
            
            onPressed: (){
              // print("object");
              print(pageController?.page);
              if(pageController!.page! > 0){
                
                pageController!.nextPage(duration: const Duration(microseconds: 500), curve: Curves.easeInSine);
                print("get nextPage");
              }
              else{
                print("get started");
                Navigator.of(context).pushNamed("/login");
              }
            },
            style: ButtonStyle(
               padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15, vertical: 13)),
              backgroundColor: WidgetStateProperty.all(
                Globals.btncolor,
              ),
            ),
            child:  Text(
              pageController!.hasClients && pageController!.page == 0 ? "Get Started" : "Next",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ),
        ),
      ],
    );
  }
}
