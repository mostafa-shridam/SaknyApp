import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/models/post_model.dart';
import 'package:sakny/models/user_model.dart';
import 'package:video_player/video_player.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  static PostCubit get(context) => BlocProvider.of(context);
  SaknyUserModel? model;

  void getUsersData() {
    emit(GetUserDataLoading());
    FirebaseFirestore.instance.collection(kUser).doc(uId).get().then((value) {
      model = SaknyUserModel.fromJson(value.data());
      emit(GetUserDataSuccess());
    }).catchError((e) {
      emit(GetUserDataError());
    });
  }

  List<SaknyUserModel> users = [];

  var picker = ImagePicker();

  File? postImage;
  File? postVideo;

  Future<void> getPostImage({
    required ImageSource source,
  }) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      log(pickedFile.path);
      emit(GetPostImageSuccess());
    } else {
      print('No image post selected');
      emit(GetPostImageError());
    }
  }

  void removePostImage() {
    postImage = null;

    emit(RemovePostImageSuccess());
  }

  void uploadPostImage({
    required String postDate,
    required String text,
  }) async {
    emit(CreatePostLoading());
    await FirebaseStorage.instance
        .ref()
        .child('$kPosts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPostImage(
          postDate: postDate,
          text: text,
          postImage: value,
        );
        emit(CreatePostSuccess());
      }).catchError((e) {
        emit(CreatePostError());
        print(e.toString());
      });
      print(value);
    }).catchError((e) {
      emit(CreatePostError());
      print(e.toString());
    });
  }

  Future<void> getPostVideo({
    required ImageSource source,
  }) async {
    final pickedFile = await picker.pickVideo(source: source);

    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      log(pickedFile.path);
      emit(GetPostVideoSuccess());
    } else {
      print('No video post selected');
      emit(GetPostVideoError());
    }
  }

  VideoPlayerController? controller;

  void removePostVideo() {
    postVideo = null;
    emit(RemovePostVideoSuccess());
  }

  void uploadPostVideo({
    required String postDate,
    required String text,
  }) async {
    emit(CreatePostLoading());
    await FirebaseStorage.instance
        .ref()
        .child('$kPosts/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(postVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPostVideo(
          postDate: postDate,
          text: text,
          postVideo: value,
        );
        emit(CreatePostSuccess());
      }).catchError((e) {
        emit(CreatePostError());
        print(e.toString());
      });
      print(value);
    }).catchError((e) {
      emit(CreatePostError());
      print(e.toString());
    });
  }

  void createPostImage({
    required String postDate,
    required String text,
    String? postImage,
  }) async {
    emit(CreatePostLoading());
    PostModel createPostModel = PostModel(
      name: model?.name,
      image: model?.image,
      uId: model?.uId,
      text: text,
      postDate: postDate,
      postImage: postImage ?? '',
    );
    try {
      FirebaseFirestore.instance
          .collection(kPosts)
          .add(createPostModel.toMap());
      emit(CreatePostSuccess());
    } catch (e) {
      emit(CreatePostError());
    }
  }

  void createPostVideo({
    required String postDate,
    required String text,
    String? postVideo,
  }) async {
    emit(CreatePostLoading());
    PostModel createPostModel = PostModel(
      name: model?.name,
      image: model?.image,
      uId: model?.uId,
      text: text,
      postDate: postDate,
      postVideo: postVideo ?? '',
    );
    try {
      FirebaseFirestore.instance
          .collection(kPosts)
          .add(createPostModel.toMap());
      emit(CreatePostSuccess());
    } catch (e) {
      emit(CreatePostError());
    }
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> favourite = [];

  void getPosts() {
    emit(GetPostsLoading());
    FirebaseFirestore.instance.collection(kPosts).snapshots().listen((value) {
      posts = [];
      for (var element in value.docs) {
        favourite = [];
        element.reference.collection('favourites').get().then((value) {
          postsId.add(element.id);
          posts.add(
            PostModel.fromJson(element.data()),
          );
          favourite.add(value.docs.length);
        }).catchError((e) {
          emit(GetPostsError(e.toString()));
        });
      }
      emit(GetPostsSuccess(post: posts));
    }).onError((e) {
      emit(GetPostsError(e.toString()));
    });
  }

  void getFavourite(String postsId) {
    emit(FavouritesPostsLoading());
    try {
      FirebaseFirestore.instance
          .collection(kPosts)
          .doc(postsId)
          .collection('favourites')
          .doc(model?.uId)
          .set({
        'favourites': true,
      });
      emit(FavouritesPostsSuccess());
    } catch (e) {
      emit(FavouritesPostsError());
    }
  }

  Future<void> removePost(postId) {
    return FirebaseFirestore.instance.collection(kPosts).doc(postId).delete();
  }
}
