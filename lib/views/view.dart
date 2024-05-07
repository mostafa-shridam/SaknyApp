// ignore_for_file: file_names

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/cubit/cubit/states.dart';
import 'package:sakny/views/add_view.dart';
import 'package:sakny/views/search_view.dart';
import 'package:sakny/views/users_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static String id = 'nav';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is AddPostScreenState) {
          Navigator.pushNamed(context, AddScreen.id);
        }
      },
      builder: (context, state) {
        UserCubit cubit = UserCubit.get(context);
        return Scaffold(
          endDrawerEnableOpenDragGesture: true,
          extendBody: true,
          appBar: AppBar(
            primary: true,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, UsersWidget.id);
                },
                icon: Image.asset('assets/chat.png'),
                iconSize: 34,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.id);
                },
                icon: const Icon(
                  Icons.search_outlined,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
            backgroundColor: defaultColor,
            title: Text(
              cubit.model?.type == 'Admin'
                  ? cubit.titleAdmin[cubit.selectedTab]
                  : cubit.titleUser[cubit.selectedTab],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: cubit.model?.type == 'Admin'
              ? cubit.screensAdmin[cubit.selectedTab]
              : cubit.screensUser[cubit.selectedTab],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: DotNavigationBar(
              margin: const EdgeInsets.only(left: 5, right: 6),
              currentIndex: cubit.selectedTab,
              dotIndicatorColor: Colors.black,
              unselectedItemColor: Colors.white,
              splashBorderRadius: 50,
              enableFloatingNavBar: true,
              marginR: const EdgeInsets.all(14),
              paddingR: const EdgeInsets.all(12),
              backgroundColor: defaultColor,
              selectedItemColor: Colors.black,
              enablePaddingAnimation: false,
              onTap: (index) {
                cubit.model?.type == 'Admin'
                    ? cubit.changeIndexAdmin(index)
                    : cubit.changeIndexUser(index);
              },
              items: [
                DotNavigationBarItem(
                  icon: const Icon(Icons.home),
                  selectedColor: Colors.black,
                ),
                DotNavigationBarItem(
                  icon: const Icon(
                    Icons.favorite,
                  ),
                  selectedColor: Colors.black,
                ),
                if (cubit.model?.type == 'Admin')
                  DotNavigationBarItem(
                    icon: const Icon(Icons.add_circle_outlined),
                    selectedColor: Colors.black,
                  ),
                DotNavigationBarItem(
                  icon: const Icon(Icons.notifications),
                  selectedColor: Colors.black,
                ),
                DotNavigationBarItem(
                  icon: const Icon(Icons.person),
                  selectedColor: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
