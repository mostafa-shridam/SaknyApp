import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/message_cubit/states.dart';
import 'package:sakny/models/message-model.dart';
import 'package:sakny/models/user_model.dart';

class MessagesCubit extends Cubit<MessageStates> {
  MessagesCubit() : super(MessageInitial());

  static MessagesCubit get(context) => BlocProvider.of(context);

  // CollectionReference messagesList = ;

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

  // void getUsers() {
  //   if (users.isEmpty) {
  //     FirebaseFirestore.instance.collection(kUser).snapshots().listen((value) {
  //       users = [];
  //       for (var element in value.docs) {
  //         if (element.data()['uId'] != model?.uId) {
  //           users.add(
  //             SaknyUserModel.fromJson(element.data()),
  //           );
  //         }
  //       }
  //     });
  //   }
  // }

  void sendMessage({
    required String receiverId,
    required String messageDate,
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
      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageError(e.toString()));
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
      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageError(e.toString()));
    }
  }

  List<MessageModel> messages = [];

  Future<void> getMessages({
    String? receiverId,
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
        print('messages is : ${event.docs}');
      }
      emit(GetMessageSuccess());
    }).cancel();
  }
}
