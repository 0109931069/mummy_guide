import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
// Make sure to add this package for animations
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/utils/size_conf.dart';
import 'package:mummy_guide/widgets/wisdom_widget.dart'; // Adjust the import according to your project structure

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  List<Widget> carouselItems = [
    WisdomeWidget(
      imagePath:"assets/images/mom1.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom2.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom3.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom4.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom5.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom6.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom7.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom8.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),
    WisdomeWidget(
      imagePath:"assets/images/mom9.jpg",
      wisdom: "الجنه تحت اقدام المهات",
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLocale?.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Globals.white,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "MummyGuide",
            style: GoogleFonts.agbalumo(
              fontSize: 26,
              fontWeight: FontWeight.bold,
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
        body: Column(
          children: [
            const Text("welcome yo mummyguide"),
            const SizedBox(
              height: 100,
            ),
            CarouselSlider(
              items: carouselItems,
              options: CarouselOptions(
                height: SizeConfig.screenHeight! * .3,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                viewportFraction: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
