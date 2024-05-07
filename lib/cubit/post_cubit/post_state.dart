part of 'post_cubit.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class GetUserDataLoading extends PostState {}

class GetUserDataSuccess extends PostState {}

class GetUserDataError extends PostState {}

class GetPostImageSuccess extends PostState {}

class GetPostImageError extends PostState {}

class RemovePostImageSuccess extends PostState {}

class CreatePostLoading extends PostState {}

class CreatePostSuccess extends PostState {}

class CreatePostError extends PostState {}

class GetPostVideoSuccess extends PostState {}

class GetPostVideoError extends PostState {}

class RemovePostVideoSuccess extends PostState {}

class GetPostsLoading extends PostState {}

class GetPostsSuccess extends PostState {
  final List<PostModel> post;

  GetPostsSuccess({required this.post});
}

class GetPostsError extends PostState {
  final String error;

  GetPostsError(this.error);
}

class FavouritesPostsLoading extends PostState {}

class FavouritesPostsSuccess extends PostState {}

class FavouritesPostsError extends PostState {}
