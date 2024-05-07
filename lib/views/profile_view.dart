import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:reactive_theme/reactive_theme.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/cubit/cubit/states.dart';
import 'package:sakny/views/about_view.dart';
import 'package:sakny/views/edit_profile_view.dart';
import 'package:sakny/views/login_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is SaknyLogOutUsersSuccessState) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.id,
              (route) => false,
        );
      }
    }, builder: (context, state) {
      var userModel = UserCubit
          .get(context)
          .model;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,
          centerTitle: true,
          title: LoadingOverlay(
            isLoading: state is SaknyLogOutUsersLoadingState,
            progressIndicator: progressLoading(),
            color: Colors.black,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: defaultColor,
                  radius: 56,
                  backgroundImage: NetworkImage(
                      userModel!.image!.isEmpty
                          ? '${Icon(Icons.person,) }'
                      : '${userModel.image}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userModel.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '${userModel.bio}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: 200,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
              bottomLeft: Radius.circular(60),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 70,
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, EditProfileScreen.id);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Edit profile',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    FlexibleBottomSheet();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.language),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Language',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Themes',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Center(
                              child: ReactiveThemeBtn(
                                bgColWhenLg: defaultColor,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AboutWidget.id);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('About',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    UserCubit.get(context).logOut().whenComplete(
                          () =>
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.id,
                                (route) => false,
                          ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Log out',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
