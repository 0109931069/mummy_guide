import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/controllers/auth_controller.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/providers/timeline_provider.dart';
// import 'package:mummy_guide/screens/authentication/login_screen.dart';
import 'package:mummy_guide/utils/assets_utils.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/utils/size_conf.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  Timer? timer;
  int timerStart = 3;

  startTimer() {
    timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      if (timerStart == 0) {
        timer.cancel();

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return LoginScreen();
        // }));
        Navigator.of(context).pushNamed("/onbarding");
      } else {
        setState(() {
          timerStart--;
        });
      }
    });
  }

  Future<void> checkLogin() async {
    try {
      var res = await AuthController.checkLogin();
      if (res["result"] == true) {
        final timelineProvider = Provider.of<TimelineProvider>(
          context,
          listen: false,
        );

        timelineProvider.getData();

        Navigator.of(context).pushNamed("/home");
      } else {
        Navigator.of(context).pushNamed("/onboarding");
      }
    } catch (e) {
      print(e.toString());
      Navigator.of(context).pushNamed("/onboarding");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // startTimer();
    checkLogin();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Globals.bgcolor,
        body: Container(
          decoration: const BoxDecoration(
            color: Globals.bgcolor,
          ),
          child: Column(
            children: [
              const SizedBox(height: 200,),
              Image.asset(
                  AssetsUtils.logo,
                  // width: (MediaQuery.sizeOf(context).width - 60) * 0.5,
                ), 
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Mummy Guide',
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.agbalumo(
                      fontSize: 37,
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
              const SizedBox(height: 150,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      // color: Globals.btncolor,
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        color: Globals.btncolor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (MediaQuery.sizeOf(context).width - 40) * 0.5,
                            child: Text(
                              AppLocale.lets_go_label.getString(
                                context,
                              ),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Globals.white
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Globals.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
