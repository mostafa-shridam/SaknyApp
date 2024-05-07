import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/cubit/cubit/states.dart';
import 'package:sakny/custom_widgets/build_messages.dart';
import 'package:sakny/models/message-model.dart';
import 'package:sakny/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.user,
  });

  final SaknyUserModel? user;
  static String id = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var scrollController = ScrollController();
  List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is SaknyGetUsersSuccessState) {
        }
      },
      builder: (context, state) {
        UserCubit.get(context).getMessages(receiverId: widget.user!.uId!);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                return Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
              ),
            ),
            titleSpacing: 0,
            title: buildChatRow(widget.user!),
            backgroundColor: defaultColor,
          ),
          body: UserCubit.get(context).messages.isEmpty
              ? NoMessagesBody(user: widget.user!)
              : ChatListView(
                  user: widget.user!,
                ),
        );
      },
    );
  }
}
