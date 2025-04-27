import 'package:flutter/material.dart';
import 'package:mummy_guide/widgets/page_view_body.dart';

class CustomPageView extends StatelessWidget{
  const CustomPageView({super.key,@required this.pagecontroller});
  final PageController? pagecontroller;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pagecontroller,
      children: const [
       PageViewBody(
        title: "Learn Through Videos",
        image: "assets/images/on_board1.png",
        description: "Watch expert-curated parenting tutorials, baby care guides, and developmental tips",
       ),
       PageViewBody(
        title: "Digital Library",
        image: "assets/images/onboard2.png",
        description: "Access our collection of parenting books, research articles, and helpful resources",
       ),
       PageViewBody(
        title: "AI Mammy Chat",
        image: "assets/images/onboard3.png",
        description: "Get instant answers to your parenting questions from our intelligent AI assistant",
       ),
       PageViewBody(
        title: "Parent Community",
        image: "assets/images/onboard4.png",
        description: "Connect with other parents, share experiences, and get support on your parenting journey",
       ),
      ],
    );
  }
}