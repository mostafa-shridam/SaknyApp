import 'package:sakny/models/message-model.dart';
import 'package:sakny/models/post_model.dart';

abstract class UserStates {}

class InitialStates extends UserStates {}

class AddPostScreenState extends UserStates {}

class BottomNavChangedStates extends UserStates {}

class SaknyLogOutUsersLoadingState extends UserStates {}

class SaknyLogOutUsersSuccessState extends UserStates {}

class SaknyGetUsersLoadingState extends UserStates {}

class SaknyGetUsersSuccessState extends UserStates {}

class SaknyGetUsersErrorState extends UserStates {
  final String error;

  SaknyGetUsersErrorState(this.error);
}

class SaknyGetProfileImageSuccessState extends UserStates {}

class SaknyGetProfileImageErrorState extends UserStates {}

class SaknyUpdateUserErrorState extends UserStates {
  final String error;

  SaknyUpdateUserErrorState(this.error);
}

class SaknyUpdateUserLoadingState extends UserStates {}

class SaknyUpdateUserSuccessState extends UserStates {}

class SaknyUploadProfileImageSuccessState extends UserStates {}

class SaknyUploadProfileImageErrorState extends UserStates {}

// posts
class SaknyGetPostImageSuccessState extends UserStates {}

class SaknyGetPostImageErrorState extends UserStates {}

class SaknyRemovePostImageSuccessState extends UserStates {}

class SaknyGetPostVideoSuccessState extends UserStates {}

class SaknyGetPostVideoErrorState extends UserStates {}

class SaknyRemovePostVideoSuccessState extends UserStates {}

class SaknyCreatePostLoadingState extends UserStates {}

class SaknyCreatePostSuccessState extends UserStates {}

class SaknyCreatePostErrorState extends UserStates {}

class SaknyGetPostsLoadingState extends UserStates {}

class SaknyGetPostsSuccessState extends UserStates {
  final List<PostModel> posts;

  SaknyGetPostsSuccessState({required this.posts});
}

class SaknyGetPostsErrorState extends UserStates {
  final String error;

  SaknyGetPostsErrorState(this.error);
}

class SaknyFavouritesPostsLoadingState extends UserStates {}

class SaknyFavouritesPostsSuccessState extends UserStates {}

class SaknyFavouritesPostsErrorState extends UserStates {
  final String error;

  SaknyFavouritesPostsErrorState(this.error);
}

//users

class SaknyGetAllUsersLoadingState extends UserStates {}

class SaknyGetAllUsersSuccessState extends UserStates {
  // final List<MessageModel> message;
  //
  // SaknyGetAllUsersSuccessState({required this.message});
}

class SaknyGetAllUsersErrorState extends UserStates {
  final String error;

  SaknyGetAllUsersErrorState(this.error);
}

// message

class SaknySendMessageSuccessState extends UserStates {}

class SaknySendMessageErrorState extends UserStates {
  final String error;

  SaknySendMessageErrorState(this.error);
}

class SaknyRemoveMessageSuccessState extends UserStates {}

class SaknyGetMessageSuccessState extends UserStates
{
  List<MessageModel> messages;
  SaknyGetMessageSuccessState({required this.messages});
}

class SaknyGetMessageErrorState extends UserStates {
  final String error;

  SaknyGetMessageErrorState(this.error);
}

class SaknyCreateMessagePhotoLoadingState extends UserStates {}

class SaknyCreateMessagePhotoSuccessState extends UserStates {}

class SaknyCreateMessagePhotoErrorState extends UserStates {}

class SaknyGetMessagePhotoLoadingState extends UserStates {}

class SaknyGetMessagePhotoSuccessState extends UserStates {}

class SaknyGetMessagePhotoErrorState extends UserStates {}

class SaknyNotificationSuccessState extends UserStates {}

class SaknyNotificationErrorState extends UserStates {}

//record

class RecorderClosedSuccess extends UserStates {}
