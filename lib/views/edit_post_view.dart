// import 'dart:io';
//
// import 'package:date_format/date_format.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sakny/componantes/componantes.dart';
// import 'package:sakny/cubit/cubit/cubit.dart';
// import 'package:sakny/cubit/cubit/states.dart';
// import 'package:sakny/models/post_model.dart';
// import 'package:sakny/views/view.dart';
// import 'package:video_player/video_player.dart';
//
// var textController = TextEditingController();
//
// class EditPostScreen extends StatelessWidget {
//   static String id = 'edit post';
//
//   const EditPostScreen({super.key, @required this.postModel});
//
//   final PostModel? postModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserCubit, UserStates>(
//       listener: (context, state) {
//         if (state is SaknyCreatePostSuccessState) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             BottomNavBar.id,
//             (route) => false,
//           );
//           textController.clear();
//           UserCubit.get(context).removePostImage();
//           UserCubit.get(context).removePostVideo();
//         }
//       },
//       builder: (context, state) {
//         final userData = UserCubit.get(context).model;
//         return Scaffold(
//           resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   right: 12.0,
//                 ),
//                 child: UserCubit.get(context).postVideo != null
//                     ? const CreatePostVideoButton()
//                     : const CreatePostImageButton(),
//               ),
//             ],
//             titleSpacing: -8,
//             title: const Text('Edit Post'),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_sharp),
//               onPressed: () {
//                 return Navigator.pop(context);
//               },
//             ),
//           ),
//           body: userData == null
//               ? Center(
//                   child: progressLoading(),
//                 )
//               : const Padding(
//                   padding: EdgeInsets.all(12.0),
//                   child: AddPostBody(),
//                 ),
//         );
//       },
//     );
//   }
// }
//
// class CreatePostVideoButton extends StatefulWidget {
//   const CreatePostVideoButton({super.key});
//
//   @override
//   State<CreatePostVideoButton> createState() => _CreatePostVideoButtonState();
// }
//
// class _CreatePostVideoButtonState extends State<CreatePostVideoButton> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCubit, UserStates>(
//       builder: (context, state) {
//         return TextButton(
//           onPressed: () {
//             if (UserCubit.get(context).postVideo == null) {
//               UserCubit.get(context).createPostVideo(
//                 postDate: formatDate(
//                   DateTime.now().toLocal(),
//                   [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
//                 ),
//                 text: textController.text,
//               );
//             } else {
//               UserCubit.get(context).uploadPostVideo(
//                 postDate: formatDate(
//                   DateTime.now().toLocal(),
//                   [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
//                 ),
//                 text: textController.text,
//               );
//             }
//           },
//           child: const Text(
//             'Edit',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class AddPostBody extends StatefulWidget {
//   const AddPostBody({
//     super.key,
//   });
//
//   @override
//   State<AddPostBody> createState() => _AddPostBodyState();
// }
//
// class _AddPostBodyState extends State<AddPostBody> {
//   var editController = TextEditingController();
//   PostModel? postModel;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserCubit, UserStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var userModel = UserCubit.get(context).posts;
//         if (userModel.isEmpty) {
//           return const Center(
//             child: Padding(
//               padding: EdgeInsets.only(top: 6),
//               child: LinearProgressIndicator(
//                 color: Colors.black,
//               ),
//             ),
//           );
//         }
//         var userData = UserCubit.get(context).model;
//         return BlocBuilder<UserCubit, UserStates>(
//           builder: (context, state) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 if (state is SaknyCreatePostLoadingState ? true : false)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: LinearProgressIndicator(
//                       backgroundColor: Colors.black,
//                     ),
//                   ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 26,
//                       backgroundImage: NetworkImage('${userData?.image}'),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                       ),
//                       child: Text(
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         '${userData?.name}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: TextFormField(
//                       controller: editController,
//                       maxLines: 6,
//                       minLines: 1,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: '${postModel?.text}'),
//                     ),
//                   ),
//                 ),
//                 if (UserCubit.get(context).postImage != null ||
//                     UserCubit.get(context).postVideo != null)
//                   const RemoveVideoOrImageButton(),
//                 const Row(
//                   children: [
//                     GetImage(),
//                     GetVideo(),
//                   ],
//                 )
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// class RemoveVideoOrImageButton extends StatefulWidget {
//   const RemoveVideoOrImageButton({super.key});
//
//   @override
//   State<RemoveVideoOrImageButton> createState() =>
//       _RemoveVideoOrImageButtonState();
// }
//
// class _RemoveVideoOrImageButtonState extends State<RemoveVideoOrImageButton> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCubit, UserStates>(
//       builder: (context, state) {
//         return Stack(
//           fit: StackFit.loose,
//           children: [
//             if (UserCubit.get(context).postImage != null) const ImageFile(),
//             if (UserCubit.get(context).postVideo != null)
//               const VideoController(),
//             IconButton(
//               splashRadius: 20,
//               onPressed: () {
//                 UserCubit.get(context).removePostImage();
//                 UserCubit.get(context).removePostVideo();
//                 setState(() {});
//               },
//               icon: const CircleAvatar(
//                 radius: 12,
//                 child: Icon(
//                   Icons.close,
//                   size: 16,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class GetImage extends StatelessWidget {
//   const GetImage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCubit, UserStates>(
//       builder: (context, state) {
//         return Expanded(
//           child: InkWell(
//             borderRadius: BorderRadius.circular(10),
//             onTap: () {
//               UserCubit.get(context).getPostImage(source: ImageSource.gallery);
//             },
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Add Image',
//                     style: TextStyle(
//                       color: defaultColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.photo_camera_back_outlined,
//                       color: defaultColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class GetVideo extends StatelessWidget {
//   const GetVideo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: () {
//           UserCubit.get(context).getPostVideo(
//             source: ImageSource.gallery,
//           );
//         },
//         child: const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Add Video',
//                   style: TextStyle(
//                     color: defaultColor,
//                     fontWeight: FontWeight.bold,
//                   )),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Icon(
//                   Icons.video_collection_outlined,
//                   color: defaultColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class VideoController extends StatelessWidget {
//   const VideoController({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     VideoPlayerController controller = VideoPlayerController.file(
//       UserCubit.get(context).postVideo as File,
//     );
//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: FlickVideoPlayer(
//         flickManager: FlickManager(videoPlayerController: controller),
//       ),
//     );
//   }
// }
//
// class ImageFile extends StatelessWidget {
//   const ImageFile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Image image = Image.file(
//       UserCubit.get(context).postImage as File,
//     );
//     return Image(
//       height: 400,
//       width: double.infinity,
//       fit: BoxFit.contain,
//       image: image.image,
//       filterQuality: FilterQuality.high,
//     );
//   }
// }
//
// class CreatePostImageButton extends StatefulWidget {
//   const CreatePostImageButton({super.key});
//
//   @override
//   State<CreatePostImageButton> createState() => _CreatePostImageButtonState();
// }
//
// class _CreatePostImageButtonState extends State<CreatePostImageButton> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCubit, UserStates>(
//       builder: (context, state) {
//         return TextButton(
//           onPressed: () {
//             if (UserCubit.get(context).postImage == null) {
//               UserCubit.get(context).createPostImage(
//                 postDate: formatDate(
//                   DateTime.now().toLocal(),
//                   [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
//                 ),
//                 text: textController.text,
//               );
//             } else {
//               UserCubit.get(context).uploadPostImage(
//                 postDate: formatDate(
//                   DateTime.now().toLocal(),
//                   [yyyy, '-', mm, '-', dd, '  ', hh, ':', nn, ' ', am],
//                 ),
//                 text: textController.text,
//               );
//             }
//           },
//           child: const Text(
//             'Edit',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
