import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const defaultColor = Color(0xFFA6B98B);

const  colorList = [
  const Color(0xFF606F49),
  const Color(0xFF728359),
  const Color(0xFF849669),
  const Color(0xFF97A97C),
  const Color(0xFFA6B98B),
];


MaterialColor myCustomSwatch = const MaterialColor(
  0xFFEDDCD2, // replace with your chosen color's hex code
  <int, Color>{
    50: Color(0xFFE9F5DB),
    100: Color(0xFFDCEBCA),
    200: Color(0xFFCFE1B9),
    300: Color(0xFFC2D5AA),
    400: Color(0xFFB5C99A),
    500: Color(0xFFA6B98B),
    600: Color(0xFF97A97C),
    700: Color(0xFF849669),
    800: Color(0xFF728359),
    900: Color(0xFF606F49),
  },
);
String uId = FirebaseAuth.instance.currentUser?.uid ?? '';

const kUser = 'users';
const kPosts = 'posts';
const kChats = 'chats';
const kMessage = 'messages';
const futureUserId = '';

const webRecaptchaKey = 'AIzaSyBGF1ly45x7UnElRhiBlceMMyMHRN0qqe8';

Widget progressLoading() {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Container(
        alignment: AlignmentDirectional.topCenter,
        height: 84,
        width: 84,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: LoadingAnimationWidget.inkDrop(
            color: defaultColor,
            size: 30,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          'Loading..',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
