import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mummy_guide/controllers/comments_controller.dart';
import 'package:mummy_guide/controllers/post_interactions_controller.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/providers/post_provider.dart';
import 'package:mummy_guide/providers/timeline_provider.dart';
import 'package:mummy_guide/screens/common/photo_viewer_screen.dart';
import 'package:mummy_guide/utils/assets_utils.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:mummy_guide/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  final Map<String, dynamic> post;
  final bool showActions;
  final bool canNavigate;

  const PostWidget({
    super.key,
    required this.post,
    this.showActions = true,
    this.canNavigate = true,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;

  bool isReacted = false;
  String selectedReaction = "like";
  List<Map<String, dynamic>> reactions = [];

  Map<String, dynamic> myReaction = {};

  int commentsCount = 0;

  Future<void> getPostInteractions() async {
    try {
      var res = await PostInteractionsController.getPostInteractions(
        widget.post["id"],
      );

      if (res["result"] == true) {
        final fetchedReactions = (res["data"] as List)
            .map(
              (d) => Map<String, dynamic>.from(
                d as Map,
              ),
            )
            .toList();

        final mine = fetchedReactions.firstWhere(
          (element) => element["isMine"] == true,
          orElse: () => {},
        );

        setState(() {
          reactions = fetchedReactions;
          if (mine.isNotEmpty) {
            myReaction = mine;
            selectedReaction = myReaction["react_type"].toString();
            isReacted = true;
          } else {
            myReaction = {};
            selectedReaction = "like";
            isReacted = false;
          }
        });
      }
    } catch (e) {
      // Consider logging error instead of print
    }
  }

  Future<void> getCommentsCount() async {
    try {
      var res = await CommentsController.getCommentsCountForPost(
        widget.post["id"],
      );

      setState(() {
        commentsCount = res;
      });
    } catch (e) {
      // Consider logging error instead of print
    }
  }

  Future<void> getData() async {
    await getPostInteractions();
    await getCommentsCount();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final timeLineProvider = Provider.of<TimelineProvider>(context);

    return Card(
      child: InkWell(
        onTap: () async {
          if (widget.canNavigate) {
            final postProvider = Provider.of<PostProvider>(
              context,
              listen: false,
            );

            postProvider.setCurrentPost(widget.post);
            postProvider.getData();

            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(
              "/view_post",
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width - 10,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 5),
                      _buildContentText(context),
                      const SizedBox(height: 5),
                      _buildMediaCarousel(context),
                      const SizedBox(height: 10),
                      _buildReactionsCommentsShares(context),
                      if (widget.showActions) const SizedBox(height: 5),
                      if (widget.showActions) _buildActionButtons(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 40) * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildUserPhoto(),
              const SizedBox(width: 10),
              _buildUserNameAndTime(context),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }

  Widget _buildUserPhoto() {
    if (widget.post["user_photo"] == "") {
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          image: DecorationImage(
            image: AssetImage(AssetsUtils.profileAvatar),
          ),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: widget.post["user_photo"],
        imageBuilder: (context, imageProvider) => Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }

  Widget _buildUserNameAndTime(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 65) * 0.4,
          child: TextWidget(
            text: widget.post["username"].toString(),
            textAlign: TextAlign.end,
          
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 65) * 0.4,
          child: Text(
            timeago.format(
              DateTime.parse(widget.post["date_added"].toString()),
              locale: localization.currentLocale.localeIdentifier == 'ar'
                  ? "ar"
                  : localization.currentLocale.localeIdentifier == 'en'
                      ? 'en_short'
                      : localization.currentLocale.localeIdentifier,
            ),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildContentText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 40) * 0.9,
          child: TextWidget(
            text: widget.post["parsedContent"]["text"].toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildMediaCarousel(BuildContext context) {
    if (widget.post["parsedContent"]["media"].toString() == "" ||
        widget.post["parsedContent"]["media"].isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        CarouselSlider(
          items: (widget.post["parsedContent"]["media"] as List)
              .map(
                (item) => item["type"] == "photo"
                    ? CachedNetworkImage(
                        imageUrl: item["url"].toString(),
                        imageBuilder: (context, imageProvider) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PhotoViewerScreen(
                                  url: item["url"].toString(),
                                );
                              },
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      )
                    : FlickVideoPlayer(
                        flickManager: FlickManager(
                          autoPlay: false,
                          videoPlayerController: VideoPlayerController.networkUrl(
                            Uri.parse(item["url"].toString()),
                            videoPlayerOptions:  VideoPlayerOptions(
                              allowBackgroundPlayback: false,
                            ),
                          ),
                        ),
                      ),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: false,
            enlargeCenterPage: false,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            viewportFraction: 1.0,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(5),
              child: Text(
                "${(currentIndex + 1)}/${widget.post["parsedContent"]["media"].length}",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReactionsCommentsShares(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 60) * 0.33,
          child: Text(
            "${reactions.length} ${AppLocale.reactions_label.getString(context)}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 60) * 0.33,
          child: Text(
            "$commentsCount ${AppLocale.comments_label.getString(context)}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: (MediaQuery.sizeOf(context).width - 60) * 0.33,
          child: Text(
            "        0 ${AppLocale.shares_label.getString(context)}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            if (isReacted) {
              await PostInteractionsController.updateReactionToPost(
                  widget.post["id"], "like");
            } else {
              await PostInteractionsController.addReactionToPost(
                  widget.post["id"], "like");
            }
            setState(() {
              isReacted = !isReacted;
            });
          },
          label: Text(
            AppLocale.like_label.getString(context),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Globals.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          icon: Icon(
            isReacted ? Icons.favorite : Icons.favorite_border_rounded,
            size: 15,
            color: Globals.white,
          ),
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Globals.btncolor),
            elevation: WidgetStatePropertyAll(1),
            visualDensity: VisualDensity.compact,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            if (widget.canNavigate) {
              final postProvider = Provider.of<PostProvider>(
                context,
                listen: false,
              );

              postProvider.setCurrentPost(widget.post);
              postProvider.getData();

              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(
                "/view_post",
              );
            } else {
              final postProvider = Provider.of<PostProvider>(
                context,
                listen: false,
              );

              postProvider.newCommentFocusNode.requestFocus();
            }
          },
          label: Text(
            AppLocale.comment_label.getString(context),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Globals.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          icon: const Icon(
            Icons.comment,
            size: 15,
            color: Globals.white,
          ),
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Globals.btncolor),
            elevation: WidgetStatePropertyAll(1),
            visualDensity: VisualDensity.compact,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          label: Text(
            AppLocale.share_label.getString(context),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Globals.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          icon: const Icon(
            Icons.share,
            size: 15,
            color: Colors.white,
          ),
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Globals.btncolor),
            elevation: WidgetStatePropertyAll(1),
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
