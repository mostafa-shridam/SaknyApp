import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/post_cubit/post_cubit.dart';
import 'package:sakny/views/view.dart';
import 'package:video_player/video_player.dart';

var textController = TextEditingController();

class AddScreen extends StatelessWidget {
  static String id = 'add post';

  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavBar.id,
            (route) => false,
          );
          textController.clear();
          PostCubit.get(context).removePostImage();
          PostCubit.get(context).removePostVideo();
        }
      },
      builder: (context, state) {
        final userData = PostCubit.get(context).model;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                ),
                child: PostCubit.get(context).postVideo != null
                    ? const CreatePostVideoButton()
                    : const CreatePostImageButton(),
              ),
            ],
            titleSpacing: -8,
            title: const Text('Add Post'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                return Navigator.pop(context);
              },
            ),
          ),
          body: userData == null
              ? Center(
                  child: progressLoading(),
                )
              : AbsorbPointer(
                  absorbing: state is CreatePostLoading ? true : false,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: AddPostBody(),
                  ),
                ),
        );
      },
    );
  }
}

class CreatePostVideoButton extends StatefulWidget {
  const CreatePostVideoButton({super.key});

  @override
  State<CreatePostVideoButton> createState() => _CreatePostVideoButtonState();
}

class _CreatePostVideoButtonState extends State<CreatePostVideoButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            if (PostCubit.get(context).postVideo == null) {
              PostCubit.get(context).createPostVideo(
                postDate: formatDate(
                  DateTime.now().toLocal(),
                  [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
                ),
                text: textController.text,
              );
            } else {
              PostCubit.get(context).uploadPostVideo(
                postDate: formatDate(
                  DateTime.now().toLocal(),
                  [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
                ),
                text: textController.text,
              );
            }
          },
          child: const Text(
            'Post',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}

class AddPostBody extends StatelessWidget {
  const AddPostBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        final userData = PostCubit.get(context).model;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (state is CreatePostLoading ? true : false)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              ),
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage('${userData?.image}'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    '${userData?.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: textController,
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Whats in your mind ${userData?.name}...',
                  ),
                ),
              ),
            ),
            if (PostCubit.get(context).postImage != null ||
                PostCubit.get(context).postVideo != null)
              const RemoveVideoOrImageButton(),
            const Row(
              children: [
                GetImage(),
                GetVideo(),
              ],
            )
          ],
        );
      },
    );
  }
}

class RemoveVideoOrImageButton extends StatefulWidget {
  const RemoveVideoOrImageButton({super.key});

  @override
  State<RemoveVideoOrImageButton> createState() =>
      _RemoveVideoOrImageButtonState();
}

class _RemoveVideoOrImageButtonState extends State<RemoveVideoOrImageButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.loose,
          children: [
            if (PostCubit.get(context).postImage != null) const ImageFile(),
            if (PostCubit.get(context).postVideo != null)
              const VideoController(),
            IconButton(
              splashRadius: 20,
              onPressed: () {
                PostCubit.get(context).removePostImage();
                PostCubit.get(context).removePostVideo();
                setState(() {});
              },
              icon: const CircleAvatar(
                radius: 12,
                child: Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class GetImage extends StatelessWidget {
  const GetImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              PostCubit.get(context).getPostImage(source: ImageSource.gallery);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Image',
                    style: TextStyle(
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.photo_camera_back_outlined,
                      color: defaultColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GetVideo extends StatelessWidget {
  const GetVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          PostCubit.get(context).getPostVideo(
            source: ImageSource.gallery,
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add Video',
                  style: TextStyle(
                    color: defaultColor,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.video_collection_outlined,
                  color: defaultColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoController extends StatelessWidget {
  const VideoController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    VideoPlayerController controller = VideoPlayerController.file(
      PostCubit.get(context).postVideo as File,
    );
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: FlickVideoPlayer(
        flickManager: FlickManager(
          videoPlayerController: controller,
          autoPlay: false,
        ),
      ),
    );
  }
}

class ImageFile extends StatelessWidget {
  const ImageFile({super.key});

  @override
  Widget build(BuildContext context) {
    Image image = Image.file(
      PostCubit.get(context).postImage as File,
    );
    return Image(
      height: 400,
      width: double.infinity,
      fit: BoxFit.contain,
      image: image.image,
      filterQuality: FilterQuality.high,
    );
  }
}

class CreatePostImageButton extends StatefulWidget {
  const CreatePostImageButton({super.key});

  @override
  State<CreatePostImageButton> createState() => _CreatePostImageButtonState();
}

class _CreatePostImageButtonState extends State<CreatePostImageButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            if (PostCubit.get(context).postImage == null) {
              PostCubit.get(context).createPostImage(
                postDate: formatDate(
                  DateTime.now().toLocal(),
                  [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
                ),
                text: textController.text,
              );
            } else {
              PostCubit.get(context).uploadPostImage(
                postDate: formatDate(
                  DateTime.now().toLocal(),
                  [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
                ),
                text: textController.text,
              );
            }
          },
          child: const Text(
            'Post',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}
