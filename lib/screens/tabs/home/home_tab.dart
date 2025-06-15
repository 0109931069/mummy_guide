import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/providers/profile_tab_provider.dart';
import 'package:mummy_guide/screens/tabs/profile/profile_tab.dart';
import 'package:mummy_guide/utils/assets_utils.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/utils/size_conf.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final profileTabProvider = Provider.of<ProfileTabProvider>(context);
    return Directionality(
        textDirection: localization.currentLocale?.localeIdentifier == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
            backgroundColor: Globals.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Navigator.of(context).pushNamed("/profile");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const  ProfileTab()),
                  );
                  // Handle settings button press
                },
              ),
              backgroundColor: Globals.btncolor.withValues(alpha: .3),
              elevation: 2,

              centerTitle: false,
              title: Text(
                // textDirection: TextDirection.ltr,
                AppLocale.mummy_guide_label,
                textAlign: TextAlign.center,
                style: GoogleFonts.agbalumo(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemGrey,
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                      duration: const Duration(milliseconds: 3000),
                      color: Globals.titlecolor)
                  .animate()
                  .fadeIn(
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutQuad)
                  .slide(),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white, // Container background color
                borderRadius: BorderRadius.circular(
                    12), // subtle rounded corners ~0.75rem
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: .1), // subtle shadow color
                    blurRadius: 8, // soft blur
                    offset: const Offset(0, 4), // vertical shadow position
                  ),
                ],
              ),
              child: Column(
                children: [
                  Center(
                    child: RichText(
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      
                      softWrap: true,
                      text: TextSpan(
                        style: GoogleFonts.agbalumo(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: "Welcome to MummyGuide ",
                            
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: profileTabProvider.username,
                            style: const TextStyle(
                                color: Globals.btncolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: AnimatedText(
                      text: AppLocale.home_description_label,
                      duration: const Duration(seconds: 30),
                      style: GoogleFonts.agbalumo(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  CarouselSlider(
                    items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/p$i.jpg",
                                  fit: BoxFit.cover,
                                  height: SizeConfig.screenHeight! * .3),
                              const SizedBox(height: 30),
                              Text(
                                AssetsUtils
                                    .quotes[i % AssetsUtils.quotes.length],
                                textDirection: TextDirection.ltr,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.agbalumo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Globals.btncolor,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: SizeConfig.screenHeight! * .5,
                      autoPlay: true,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      // aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      reverse: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      viewportFraction: 0.99,
                      enlargeFactor: 0.2,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            )));
  }
}

class AnimatedText extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle style;

  const AnimatedText({
    super.key,
    required this.text,
    required this.duration,
    required this.style,
  });

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String displayedText = "";

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    final textLength = widget.text.length;
    for (int i = 0; i <= textLength; i++) {
      Future.delayed(Duration(milliseconds: (i * 100)), () {
        setState(() {
          displayedText = widget.text.substring(0, i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText,
      style: widget.style,
      textAlign: TextAlign.center,
    );
  }
}
