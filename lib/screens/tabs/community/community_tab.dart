import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mummy_guide/providers/profile_tab_provider.dart';
import 'package:mummy_guide/providers/timeline_provider.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/widgets/post_widget.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLineProvider = Provider.of<TimelineProvider>(
      context,
    );

    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Globals.white,
        appBar: AppBar(
          backgroundColor: Globals.white,
          centerTitle: false,
          title:  Text(
            AppLocale.community_label.getString(context),
            style: GoogleFonts.agbalumo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .shimmer(duration: 3000.ms, color: Globals.titlecolor)
              .animate(
                  // onPlay: (controller) => controller.repeat(),
                  ) // this wraps the previous Animate in another Animate
              .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
              .slide(),
          actions: const [
            // IconButton(
            //   onPressed: () {
            //     final chatsProvider = Provider.of<ChatsProvider>(
            //       context,
            //       listen: false,
            //     );

            //     chatsProvider.getData();

            //     Navigator.of(
            //       context,
            //       rootNavigator: true,
            //     ).pushNamed(
            //       "/chats",
            //     );
            //   },
            //   icon: const Icon(
            //     CupertinoIcons.bubble_left_bubble_right,
            //   ),
            // ),
          ],
        ),
        body: SwipeRefresh.adaptive(
          stateStream: timeLineProvider.swipeStream,
          onRefresh: timeLineProvider.onRefresh,
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            ListView(
              padding: const EdgeInsets.only(
                bottom: 5,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      color: Globals.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.2), // Shadow color
                          // offset: Offset(0, 2), // Shadow position
                          blurRadius: 4, // Shadow blur radius
                          spreadRadius: 0, // Shadow spread radius
                        ),
                      ],
                      
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.sizeOf(context).width - 60) * 0.6,
                              child: Text(
                                AppLocale.whats_on_your_mind_label.getString(
                                  context,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.photo,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    // Go to post screen
                    final profileTabProvider = Provider.of<ProfileTabProvider>(
                      context,
                      listen: false,
                    );
        
                    await profileTabProvider.getData();
        
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamed("/new_post");
                  },
                ),
                Container(
                  height: 2,
                  color: Globals.btncolor,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                ).animate().scale(
                      duration: 1500.ms,
                      alignment: Alignment.centerLeft,
                    ),
                ...timeLineProvider.posts.map((post) {
                  post["parsedContent"] = Map<String, dynamic>.from(
                    jsonDecode(post["content"]) as Map,
                  );
        
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.1,
                    ),
                    child: PostWidget(
                      post: post,
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
