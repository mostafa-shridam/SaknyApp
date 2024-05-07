import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sakny/build/default_form_field.dart';
import 'package:sakny/build/default_selected_date.dart';
import 'package:sakny/build/default_toggle.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/componantes/helper.dart';
import 'package:sakny/cubit/create_user_cubit/app_cubit.dart';
import 'package:sakny/cubit/create_user_cubit/app_states.dart';
import 'package:sakny/shared/network/cache_helper.dart';
import 'package:sakny/views/login_view.dart';
import 'package:sakny/views/view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String id = 'signup';

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  bool isPassword = true;
  bool isLoading = false;
  DateTime? selectedDate;
  String? selectedGender;
  String? selectedType;

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
          if (state is SaknyCreateUserSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBar.id,
              (route) => false,
            );
            showSnackBar(context, 'Signup success');
            CacheHelper.saveData(key: 'futureUserId', value: true);
          } else if (state is GoogleRegistrationSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBar.id,
              (route) => false,
            );
            showSnackBar(context, 'Signup success');
            CacheHelper.saveData(key: 'futureUserId', value: true);
          } else if (state is SaknyCreateUserErrorStates) {
            showSnackBar(context, state.errorMessage.toString());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: LoadingOverlay(
              color: Colors.black,
              progressIndicator: progressLoading(),
              isLoading: state is SaknySignupLoadingState ? true : false,
              child: Form(
                  key: _formKey,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                Text(
                                  'Welcome',
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
                                  'Please signup to new account',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: Card(
                              elevation: 10,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: BorderDirectional.merge(
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
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              'SignUp',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              LoginScreen.id,
                                              (route) => false,
                                            );
                                          },
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DefaultFormField(
                                      prefixIcon:
                                          const Icon(Icons.person_outline),
                                      keyboardType: TextInputType.name,
                                      labelText: 'User Name',
                                      controller: _userNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DefaultFormField(
                                      labelText: 'Email',
                                      prefixIcon:
                                          const Icon(Icons.email_outlined),
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        if (!value.contains('@')) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DefaultFormField(
                                      prefixIcon: const Icon(Icons.phone),
                                      labelText: 'Phone',
                                      controller: _phoneController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your phone';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DefaultFormField(
                                      obscureText: isPassword,
                                      maxLines: 1,
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
                                                Icons.visibility_off_outlined,
                                              )
                                            : const Icon(
                                                Icons.remove_red_eye,
                                              ),
                                      ),
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    DefaultFormField(
                                      keyboardType: TextInputType.number,
                                      labelText: 'National ID',
                                      prefixIcon: const Icon(
                                          Icons.account_box_outlined),
                                      maxLength: 14,
                                      controller: _idController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your National ID';
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        DefaultToggle(
                                          onGenderChanged: (value) {
                                            selectedGender = value;
                                          },
                                        ),
                                        const Spacer(),
                                        DefaultSelectedDate(
                                          onDateSelected: (date) {
                                            selectedDate = DateTime.tryParse(
                                                date.toString());
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RadioMenuButton<String>(
                                          value: 'Admin',
                                          groupValue: selectedType,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedType = value!;
                                            });
                                          },
                                          child: const Text('Admin'),
                                        ),
                                        RadioMenuButton<String>(
                                          value: 'User',
                                          groupValue: selectedType,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedType = value!;
                                            });
                                          },
                                          child: const Text('User'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          SaknyCreateUserCubit.get(context)
                                              .userSignup(
                                            name: _userNameController.text,
                                            email: _emailController.text,
                                            phone: _phoneController.text,
                                            password: _passwordController.text,
                                            nationalId: _idController.text,
                                            gender: selectedGender,
                                            birthDate: selectedDate.toString(),
                                            type: selectedType.toString(),
                                          );
                                        }
                                      },
                                      child: const CircleAvatar(
                                        radius: 32,
                                        backgroundColor: defaultColor,
                                        child: Text(
                                          'SignUp',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
