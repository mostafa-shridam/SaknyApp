import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/post_cubit/post_cubit.dart';
import 'package:sakny/custom_widgets/build_post_data.dart';
import 'package:sakny/models/post_model.dart';
import 'package:video_player/video_player.dart';

class CardListView extends StatelessWidget {
  const CardListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) => buildPostCardIemView(
            PostCubit.get(context).posts[index],
            context,
            index,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: PostCubit.get(context).posts.length,
          shrinkWrap: true,
        );
      },
    );
  }

  Card buildPostCardIemView(PostModel model, context, index) {
    CachedNetworkImage image = CachedNetworkImage(
      imageUrl: '${model.postImage}',
    );

    VideoPlayerController controller = VideoPlayerController.contentUri(
      Uri.parse(
        '${model.postVideo}',
      ),
    );
    return Card(
      elevation: 2,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: defaultColor,
          width: 1,
        ),
      ),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostImageData(
              model: model,
            ),
            if (model.postVideo != '') ViewVideoPost(controller: controller),
            if (model.postImage != '')
              ViewImagePost(
                image: image,
                model: model,
              ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                right: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  model.postVideo != '' || model.postImage != ''
                      ? Expanded(
                          child: ReadMoreText(
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            '${model.text}',
                            trimCollapsedText: 'more',
                            trimExpandedText: 'less',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ReadMoreText(
                            trimLines: 8,
                            trimMode: TrimMode.Line,
                            '${model.text}',
                            trimCollapsedText: 'more',
                            trimExpandedText: 'less',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    color: defaultColor,
                    splashRadius: 14,
                    onPressed: () {
                      PostCubit.get(context).getFavourite(
                        PostCubit.get(context).postsId[index],
                      );
                    },
                    icon: CircleAvatar(
                      radius: 14,
                      backgroundColor: PostCubit.get(context).favourite.isEmpty
                          ? Colors.transparent
                          : defaultColor,
                      child: Icon(
                        color: PostCubit.get(context).favourite.isEmpty
                            ? defaultColor
                            : Colors.white,
                        Icons.favorite_border,
                        size: 22,
                        fill: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
