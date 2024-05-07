import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/cubit/states.dart';
import 'package:sakny/models/message-model.dart';
import 'package:sakny/models/user_model.dart';
import 'package:sakny/shared/network/cache_helper.dart';
import 'package:sakny/views/add_view.dart';
import 'package:sakny/views/favourite_view.dart';
import 'package:sakny/views/home_view.dart';
import 'package:sakny/views/notification_view.dart';
import 'package:sakny/views/profile_view.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialStates());

  static UserCubit get(context) => BlocProvider.of(context);

  SaknyUserModel? model;

  int selectedTab = 0;

  List<Widget> screensAdmin = <Widget>[
    const HomeScreen(),
    const FavouriteScreen(),
    const AddScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  List<Widget> screensUser = <Widget>[
    const HomeScreen(),
    const FavouriteScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  List<String> titleAdmin = [
    'Home',
    'Favourite',
    '',
    'Notifications',
    'Profile',
  ];

  List<String> titleUser = [
    'Home',
    'Favourite',
    'Notifications',
    'Profile',
  ];

  void changeIndexAdmin(int index) {
    if (index == 2) {
      emit(AddPostScreenState());
    } else {
      selectedTab = index;
      emit(BottomNavChangedStates());
    }
  }

  void changeIndexUser(int index) {
    selectedTab = index;
    emit(BottomNavChangedStates());
  }

  void getUsersData() {
    emit(SaknyGetUsersLoadingState());
    FirebaseFirestore.instance.collection(kUser).doc(uId).get().then((value) {
      model = SaknyUserModel.fromJson(value.data());
      emit(SaknyGetUsersSuccessState());
    }).catchError((e) {
      emit(SaknyGetUsersErrorState(e.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage({
    required ImageSource source,
  }) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      log(pickedFile.path);
      emit(SaknyGetProfileImageSuccessState());
    } else {
      emit(SaknyGetProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String phone,
    required String name,
    required String bio,
    String? image,
  }) async {
    await FirebaseStorage.instance
        .ref()
        .child('$kUser/${Uri.file(profileImage?.path ?? '').pathSegments.last}')
        .putFile(profileImage ?? File(''))
        .then((value) {
      value.ref.getDownloadURL().then((data) {
        updateUser(
          phone: phone,
          name: name,
          bio: bio,
          image: data,
        );
        emit(SaknyUploadProfileImageSuccessState());
      }).catchError((e) {
        emit(SaknyUploadProfileImageErrorState());
        print(e.toString());
      });
      print(value);
    }).catchError((e) {
      emit(SaknyUploadProfileImageErrorState());
      print(e.toString());
    });
  }

  void updateUser({
    required String phone,
    required String name,
    required String bio,
    String? image,
  }) async {
    emit(SaknyUpdateUserLoadingState());
    if (profileImage != null) {
      uploadProfileImage(
        phone: phone,
        name: name,
        bio: bio,
      );
    } else {
      SaknyUserModel userModel = SaknyUserModel(
        isEmailVerified: model?.isEmailVerified,
        gender: model?.gender,
        birthDate: model?.birthDate,
        nationalId: model?.nationalId,
        type: model?.type,
        bio: bio,
        image: image ?? model?.image,
        email: model?.email,
        uId: model?.uId,
        phone: phone,
        name: name,
      );
      await FirebaseFirestore.instance
          .collection(kUser)
          .doc(uId)
          .set(userModel.toMap())
          .then((value) {
        getUsersData();
        emit(SaknyUpdateUserSuccessState());
      }).catchError((e) {
        emit(SaknyUpdateUserErrorState(e.toString()));
      });
    }
  }

  Future<void> logOut({context}) async {
    emit(SaknyLogOutUsersLoadingState());

    try {
      await FirebaseAuth.instance.signOut();

      await CacheHelper.sharedPreferences?.clear();
      model?.uId == null;
      emit(SaknyLogOutUsersSuccessState());
    } catch (e) {
      print('not logged out');
    }
  }

  List<SaknyUserModel> users = [];

  void getUsers() {
    emit(SaknyGetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection(kUser).snapshots().listen((value) {
        users = [];
        for (var element in value.docs) {
          if (element.data()['uId'] != model?.uId) {
            users.add(
              SaknyUserModel.fromJson(element.data()),
            );
          }
        }
        emit(SaknyGetAllUsersSuccessState());
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String messageDate,
    String? receiverName,
    String? senderName,
    required String text,
    String? photo,
    String? message,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      receiverId: receiverId,
      messageDate: messageDate,
      photo: photo ?? '',
      senderId: uId,
    );

    // sender
    try {
      FirebaseFirestore.instance
          .collection(kUser)
          .doc(uId)
          .collection(kChats)
          .doc(receiverId)
          .collection(kMessage)
          .add(messageModel.toMap());
      emit(SaknySendMessageSuccessState());
    } catch (e) {
      emit(SaknySendMessageErrorState(e.toString()));
    }

    // receiver
    try {
      FirebaseFirestore.instance
          .collection(kUser)
          .doc(receiverId)
          .collection(kChats)
          .doc(uId)
          .collection(kMessage)
          .add(messageModel.toMap());
      emit(SaknySendMessageSuccessState());
    } catch (e) {
      emit(SaknySendMessageErrorState(e.toString()));
    }
  }

  List<MessageModel> messages = [];

  Future<void> getMessages({
    required String receiverId,
  }) async {
    FirebaseFirestore.instance
        .collection(kUser)
        .doc(model?.uId)
        .collection(kChats)
        .doc(receiverId)
        .collection(kMessage)
        .orderBy(
          'messageDate',
          descending: true,
        )
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(
          MessageModel.fromJson(element.data()),
        );
      }
      emit(SaknyGetMessageSuccessState(messages: messages));
    });
  }

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Future<void> _init() async {
  //   Firebase.initializeApp();

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     emit(SaknyNotificationSuccessState());
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     emit(SaknyNotificationErrorState());
  //   });
  // }

//   Future<void> requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');

//       String? token = await _firebaseMessaging.getToken();
//       print('Token: $token');

//       _firebaseMessaging.subscribeToTopic('all');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
// }
//
// File? messagePhoto;
//
// Future<void> getMessagePhoto({
//   required ImageSource source,
// }) async {
//   final pickedFile = await picker.pickImage(source: source);
//
//   if (pickedFile != null) {
//     messagePhoto = File(pickedFile.path);
//     log(pickedFile.path);
//     emit(SaknyGetMessagePhotoSuccessState());
//   } else {
//     print('No image post selected');
//     emit(SaknyGetMessagePhotoErrorState());
//   }
// }
//
// void removeMessagePhoto() {
//   messagePhoto = null;
//
//   emit(SaknyRemovePostImageSuccessState());
// }
//
// void uploadMessagePhoto({
//   required String sendDate,
//   required String senderId,
//   required String receiverId,
//   required String text,
// }) async {
//   emit(SaknyCreateMessagePhotoLoadingState());
//   await FirebaseStorage.instance
//       .ref()
//       .child('$kMessage/${Uri.file(messagePhoto!.path).pathSegments.last}')
//       .putFile(messagePhoto!)
//       .then((value) {
//     value.ref.getDownloadURL().then((value) {
//       createMessagePhoto(
//         senderId: senderId,
//         sendDate: sendDate,
//         receiverId: receiverId,
//         messagePhoto: value,
//       );
//       emit(SaknyCreateMessagePhotoSuccessState());
//     }).catchError((e) {
//       emit(SaknyCreateMessagePhotoErrorState());
//       print(e.toString());
//     });
//     print(value);
//   }).catchError((e) {
//     emit(SaknyCreatePostErrorState());
//     print(e.toString());
//   });
// }
//
// void createMessagePhoto({
//   required String sendDate,
//   required String receiverId,
//   required String senderId,
//   String? messagePhoto,
// }) async {
//   emit(SaknyCreatePostLoadingState());
//   MessageModel createMessageModel = MessageModel(
//     sendDate: sendDate,
//     receiverId: receiverId,
//     photo: messagePhoto ?? '',
//     senderId: senderId,
//   );
//   try {
//     await FirebaseFirestore.instance
//         .collection(kPosts)
//         .add(createMessageModel.toMap());
//     emit(SaknyCreatePostSuccessState());
//   } catch (e) {
//     emit(SaknyCreatePostErrorState());
//   }
// }
// void removeMessage({
//   required String receiverId,
//   String? messageId,
// }) {
//   FirebaseFirestore.instance
//       .collection(kUser)
//       .doc(uId)
//       .collection(kChats)
//       .doc(receiverId)
//       .collection(kMessage)
//       .id;
//   emit(SaknyRemoveMessageSuccessState());
// }
//
// void removePost(String postId) {
//   FirebaseFirestore.instance.collection(kPosts).doc(postId).delete();
}
