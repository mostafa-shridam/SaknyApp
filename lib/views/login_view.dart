// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sakny/build/default_form_field.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/componantes/helper.dart';
import 'package:sakny/cubit/create_user_cubit/app_cubit.dart';
import 'package:sakny/cubit/create_user_cubit/app_states.dart';
import 'package:sakny/shared/network/cache_helper.dart';
import 'package:sakny/views/signup_view.dart';
import 'package:sakny/views/view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'login';

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = const Color(0xFF606F49);
  Color topColor = defaultColor;
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = const Color(0xFF606F49);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaknyCreateUserCubit(),
      child: BlocConsumer<SaknyCreateUserCubit, SaknyCreateUserStates>(
        listener: (context, state) {
          if (state is SaknySignInLoadingState) {
            isLoading = true;
          } else if (state is SaknySignInSuccessState) {
            showSnackBar(context, 'Login success');
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBar.id,
              (route) => false,
            );
            isLoading = false;
            CacheHelper.saveData(key: 'futureUserId', value: true);
          } else if (state is GoogleSignInSuccess) {
            log(uId.toString());
            showSnackBar(context, 'Login success');
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBar.id,
              (route) => false,
            );
            isLoading = false;
            CacheHelper.saveData(key: 'futureUserId', value: true);
          } else if (state is SaknySignInErrorState) {
            showSnackBar(context, state.error);
            isLoading = false;
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBody: false,
            body: LoadingOverlay(
              isLoading: isLoading,
              color: Colors.black,
              progressIndicator: progressLoading(),
              child: Form(
                key: formKey,
                child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  onEnd: () {
                    setState(
                      () {
                        index = index + 1;
                        bottomColor = colorList[index % colorList.length];
                        topColor = colorList[(index + 1) % colorList.length];
                      },
                    );
                  },
                  curve: Curves.bounceInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: begin,
                      end: end,
                      colors: [bottomColor, topColor],
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                  child: SingleChildScrollView(
                    reverse: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Text(
                                'Welcome back',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Please login to your account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 56,
                          ),
                          child: Card(
                            elevation: 10,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              gapPadding: 0,
                              borderSide: BorderSide.none,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                      context,
                                                      SignUpScreen.id,
                                                      (route) => false,
                                                    );
                                                  });
                                                },
                                                child: const Text(
                                                  'SignUp',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border:
                                                      BorderDirectional.merge(
                                                    const BorderDirectional(
                                                      bottom: BorderSide(
                                                        width: 3,
                                                        color: defaultColor,
                                                      ),
                                                    ),
                                                    const BorderDirectional(),
                                                  ),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 8.0,
                                                  ),
                                                  child: Text(
                                                    'Login',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          DefaultFormField(
                                            labelText: 'Email',
                                            prefixIcon: const Icon(
                                                Icons.email_outlined),
                                            controller: emailController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              if (!value.contains('@')) {
                                                return 'Please enter a valid email';
                                              }
                                              return null;
                                            },
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          DefaultFormField(
                                            obscureText: isPassword,
                                            prefixIcon:
                                                const Icon(Icons.lock_outline),
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            labelText: 'Password',
                                            suffixIcon: IconButton(
                                              splashRadius: 20,
                                              iconSize: 20,
                                              onPressed: () {
                                                setState(() {
                                                  isPassword = !isPassword;
                                                });
                                              },
                                              icon: isPassword
                                                  ? const Icon(
                                                      Icons
                                                          .visibility_off_outlined,
                                                    )
                                                  : const Icon(
                                                      Icons.remove_red_eye,
                                                    ),
                                            ),
                                            controller: passwordController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your password';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: const Text(
                                              'Forgot password?',
                                              style: TextStyle(
                                                color: defaultColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: AssetImage(
                                                'assets/facebook.png'),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              SaknyCreateUserCubit.get(context)
                                                  .signInWithGoogle();
                                            },
                                            child: const CircleAvatar(
                                              radius: 12,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                'assets/google.png',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            SaknyCreateUserCubit.get(context)
                                                .userSignIn(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        child: const CircleAvatar(
                                          radius: 32,
                                          backgroundColor: defaultColor,
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
