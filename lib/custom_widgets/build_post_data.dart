import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:sakny/models/post_model.dart';
import 'package:video_player/video_player.dart';

class PostImageData extends StatefulWidget {
  const PostImageData({
    super.key,
    required this.model,
  });

  final PostModel model;

  @override
  State<PostImageData> createState() => _PostImageDataState();
}

class _PostImageDataState extends State<PostImageData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
              '${widget.model.image}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  widget.model.postDate.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Spacer(),
          SubmenuButton(
            menuChildren: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return EditPostScreen(
                  //       postModel: widget.model,
                  //     );
                  //   },
                  // ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Edit'),
                ),
              ),
            ],
            child: const Icon(
              CupertinoIcons.ellipsis_circle,
            ),
          ),
        ],
      ),
    );
  }
}

class ViewImagePost extends StatelessWidget {
  const ViewImagePost({
    super.key,
    required this.image,
    required this.model,
  });

  final CachedNetworkImage image;
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: image.height,
        width: image.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InstaImageViewer(
          disposeLevel: DisposeLevel.high,
          disableSwipeToDismiss: false,
          backgroundIsTransparent: true,
          child: image,
        ),
      ),
    );
  }
}

class ViewVideoPost extends StatelessWidget {
  const ViewVideoPost({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CustomVideoView(controller: controller),
      ),
    );
  }
}

class CustomVideoView extends StatelessWidget {
  const CustomVideoView({
    super.key,
    required this.controller,
  });

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    FlickManager flickManager = FlickManager(
      videoPlayerController: controller,
      autoPlay: false,
      autoInitialize: true,
    );
    return FlickVideoPlayer(
      flickManager: flickManager,
    );
  }
}

// class CustomControls extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withOpacity(0.5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             icon: Icon(Icons.replay_10),
//             onPressed: () {
//               // Handle replay
//             },
//           ),
//           IconButton(
//             icon: Icon(flickManager.videoPlayerController.value.isPlaying
//                 ? Icons.pause
//                 : Icons.play_arrow),
//             onPressed: () {
//               setState(() {
//                 flickManager.videoPlayerController.value.isPlaying
//                     ? flickManager.videoPlayerController.pause()
//                     : flickManager.videoPlayerController.play();
//               });
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.fast_forward),
//             onPressed: () {
//               // Handle fast forward
//             },
//           ),
//         ],
//       ),
//     );
