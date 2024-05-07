import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/componantes/helper.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/models/message-model.dart';
import 'package:sakny/models/user_model.dart';
import 'package:vengamo_chat_ui/vengamo_chat_ui.dart';

var messageController = TextEditingController();

var scrollController = ScrollController();

class RowSendMessage extends StatelessWidget {
  const RowSendMessage({super.key, required this.user});

  final SaknyUserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(
            child: TextFieldToMessages(),
          ),
          const SizedBox(
            width: 10,
          ),
          messageController.text.isNotEmpty
              ? SendMessagesButton(
                  user: user,
                  icon: CupertinoIcons.paperplane,
                  onPressed: () {
                    UserCubit.get(context).sendMessage(
                      receiverId: user.uId.toString(),
                      messageDate: DateTime.now().toLocal().toString(),
                      text: messageController.text,
                    );
                    messageController.clear();
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                )
              : SendMessagesButton(
                  user: user,
                  icon: Icons.mic,
                  onLongPress: () {
                    showSnackBar(context, 'اهدي علي نفسك بقا');
                  },
                  onPressed: () {
                    showSnackBar(context, 'لسه معملتش المايك يعممممم');
                  },
                ),
        ],
      ),
    );
  }
}

class TextFieldToMessages extends StatelessWidget {
  const TextFieldToMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      controller: messageController,
      maxLines: 4,
      minLines: 1,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.photo,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        border: const OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        hintText: 'Type your message...',
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}

class NoMessagesBody extends StatelessWidget {
  const NoMessagesBody({super.key, this.user});

  final SaknyUserModel? user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          TextButton(
            
            onPressed: () {
              UserCubit.get(context).sendMessage(
                receiverId: user?.uId.toString() ?? '',
                messageDate: DateTime.now().toLocal().toString(),
                text: 'Hi ${user?.name}',
              );
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            child: Text(
              'Say hi to ${user?.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const TextFieldNoMessages(),
                const SizedBox(
                  width: 10,
                ),
                messageController.text.isNotEmpty
                    ? SendMessagesButton(
                        user: user!,
                        icon: CupertinoIcons.paperplane,
                        onPressed: () {
                          UserCubit.get(context).sendMessage(
                            receiverId: user!.uId.toString(),
                            messageDate: DateTime.now().toLocal().toString(),
                            text: messageController.text,
                          );
                          messageController.clear();
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      )
                    : SendMessagesButton(
                        user: user!,
                        icon: Icons.mic,
                        onLongPress: () {
                          showSnackBar(context, 'اهدي علي نفسك بقا');
                        },
                        onPressed: () {
                          showSnackBar(context, 'اهدي علي نفسك بقا');
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldNoMessages extends StatelessWidget {
  const TextFieldNoMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        textDirection: TextDirection.rtl,
        controller: messageController,
        maxLines: 4,
        minLines: 1,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              color: defaultColor,
              CupertinoIcons.photo,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          border: const OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          hintText: 'Type message...',
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class SendMessagesButton extends StatelessWidget {
  const SendMessagesButton({
    super.key,
    required this.user,
    required this.icon,
    required this.onPressed,
    this.onLongPress,
  });

  final SaknyUserModel user;
  final IconData icon;
  final void Function() onPressed;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onLongPress: onLongPress,
      minWidth: 30,
      elevation: 0,
      padding: EdgeInsets.zero,
      height: 46,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          60,
        ),
        borderSide: BorderSide.none,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: defaultColor,
      ),
    );
  }
}

class MyMessages extends StatelessWidget {
  const MyMessages({super.key, required this.model});

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 16),
      child: Align(
        alignment: Alignment.topRight,
        child: VengamoChatUI(
          isSender: true,
          onSwipe: (direction) {},
          isNextMessageFromSameSender: false,
          time: formatDate(DateTime.tryParse(model.messageDate.toString())!,
              [hh, ':', nn, '  ', am]),
          text: Text(
            '${model.text}',
          ),
          pointer: true,
          ack: Icon(
            UserCubit.get(context).messages.isEmpty
                ? CupertinoIcons.check_mark_circled
                : CupertinoIcons.check_mark_circled_solid,
            size: 14,
          ),
          senderBgColor: myCustomSwatch,
          receiverBgColor: Colors.white,
        ),
      ),
    );
  }
}

class OtherMessages extends StatelessWidget {
  const OtherMessages({super.key, required this.model});

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 60,
        left: 16,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: VengamoChatUI(
          isSender: false,
          onSwipe: (direction) {},
          isNextMessageFromSameSender: false,
          time: formatDate(DateTime.tryParse(model.messageDate.toString())!,
              [hh, ':', nn, '  ', am]),
          text: Text(
            '${model.text}',
          ),
          pointer: true,
          ack: const Icon(
            CupertinoIcons.check_mark_circled,
            size: 14,
          ),
          senderBgColor: defaultColor,
          receiverBgColor: const Color(0xFFDCEBCA),
        ),
      ),
    );
  }
}

Row buildChatRow(SaknyUserModel user) {
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: defaultColor,
        backgroundImage: NetworkImage(
          '${user.image}',
        ),
        radius: 22,
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          if (messageController.text.toString().isNotEmpty)
            const Text(
              'typing...',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
        ],
      ),
    ],
  );
}

class ChatListView extends StatelessWidget {
  const ChatListView({super.key, required this.user});

  final SaknyUserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            shrinkWrap: false,
            controller: scrollController,
            itemBuilder: (context, index) {
              var message = UserCubit.get(context).messages[index];
              if (UserCubit.get(context).model?.uId == message.receiverId) {
                return OtherMessages(
                  model: message,
                );
              }
              return MyMessages(
                model: message,
              );
            },
            itemCount: UserCubit.get(context).messages.length,
          ),
        ),
        RowSendMessage(
          user: user,
        ),
      ],
    );
  }
}
