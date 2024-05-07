import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_theme/reactive_theme.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/cubit/post_cubit/post_cubit.dart';
import 'package:sakny/firebase_options.dart';
import 'package:sakny/shared/bloc_observer.dart';
import 'package:sakny/shared/network/cache_helper.dart';
import 'package:sakny/views/about_view.dart';
import 'package:sakny/views/add_view.dart';
import 'package:sakny/views/beginning_view.dart';
import 'package:sakny/views/chat_view.dart';
import 'package:sakny/views/edit_profile_view.dart';
import 'package:sakny/views/email_verify_view.dart';
import 'package:sakny/views/home_view.dart';
import 'package:sakny/views/login_view.dart';
import 'package:sakny/views/search_view.dart';
import 'package:sakny/views/signup_view.dart';
import 'package:sakny/views/splash_view.dart';
import 'package:sakny/views/users_view.dart';
import 'package:sakny/views/view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
      webProvider: ReCaptchaV3Provider(webRecaptchaKey));
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await CacheHelper.getData(key: 'futureUserId');
  final themeMode = await ReactiveMode.getSavedThemeMode();
  ReactiveMode.getSavedThemeMode();
  runApp(Sakny(
    savedThemeMode: themeMode,
  ));
}

class Sakny extends StatelessWidget {
  final ThemeMode? savedThemeMode;

  const Sakny({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveThemer(
      savedThemeMode: savedThemeMode,
      builder: (reactiveMode) => MultiBlocProvider(
        providers: [
      
          BlocProvider(
            create: (context) => PostCubit()
              ..getPosts()
              ..getUsersData(),
          ),
          BlocProvider(
            create: (context) => UserCubit()
              ..getUsersData()
              ..getUsers(),
          ),
        ],
        child: MaterialApp(
          themeMode: reactiveMode,
          theme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.light,
            primarySwatch: myCustomSwatch,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  TextStyle(),
                ),
              ),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.dark,
            primarySwatch: myCustomSwatch,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            // SplashScreen.id: (context) => const SplashScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
            BeginningScreen.id: (context) => const BeginningScreen(),
            SignUpScreen.id: (context) => const SignUpScreen(),
            BottomNavBar.id: (context) => const BottomNavBar(),
            ChatScreen.id: (context) => const ChatScreen(),
            SearchScreen.id: (context) => const SearchScreen(),
            PhoneVerificationScreen.id: (context) =>
                const PhoneVerificationScreen(),
            UsersWidget.id: (context) =>   UsersWidget(),
            AboutWidget.id: (context) => const AboutWidget(),
            AddScreen.id: (context) => const AddScreen(),
            HomeScreen.id: (context) => const HomeScreen(),
            EditProfileScreen.id: (context) => const EditProfileScreen(),
            SplashScreen.id: (context) => const SplashScreen(),
            // EditPostScreen.id: (context) => const EditPostScreen(),
          },
          initialRoute: SplashScreen.id,
        ),
      ),
    );
  }
}
