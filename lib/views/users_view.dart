import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/cubit/cubit/states.dart';
import 'package:sakny/models/message-model.dart';
import 'package:sakny/models/user_model.dart';
import 'package:sakny/views/chat_view.dart';

class UsersWidget extends StatelessWidget {
  UsersWidget({
    super.key,
  });

  static String id = 'users';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      builder: (context, state) {
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
            titleSpacing: -8,
            title: const Text('Users'),
            backgroundColor: defaultColor,
          ),
          body: UserCubit.get(context).users.isEmpty
              ? const Center(
                  child: Text('No users yet'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: UserCubit.get(context).users.length,
                    itemBuilder: (context, index) => GetAllUsers(
                      user: UserCubit.get(context).users[index],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class GetAllUsers extends StatelessWidget {
  const GetAllUsers({
    super.key,
    required this.user,
  });

  final SaknyUserModel user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              user: user,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 84,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 12),
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(
                    '${user.image}',
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                'Hi',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  '1:12 pm',
                                  style: TextStyle(
                                    color: defaultColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
