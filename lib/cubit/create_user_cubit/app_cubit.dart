import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/create_user_cubit/app_states.dart';
import 'package:sakny/models/user_model.dart';

class SaknyCreateUserCubit extends Cubit<SaknyCreateUserStates> {
  SaknyCreateUserCubit() : super(SaknyInitialStates());

  static SaknyCreateUserCubit get(context) => BlocProvider.of(context);

  SaknyUserModel? model;

  Future<void> userSignup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String nationalId,
    required String? gender,
    required String? birthDate,
    required String type,
  }) async {
    emit(SaknySignupLoadingState());
    try {
      if (gender == null || birthDate == null) {
        return;
      }
      final auth = FirebaseAuth.instance;
      final userData = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userData.user != null) {
        userCreate(
          name: name,
          phone: phone,
          email: email,
          uId: uId.toString(),
          nationalId: nationalId,
          gender: gender,
          birthDate: birthDate,
          type: type,
        );
      }
      emit(SaknyCreateUserSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SaknyCreateUserErrorStates(errorMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SaknyCreateUserErrorStates(errorMessage: 'Email already in use'));
      } else {
        emit(SaknyCreateUserErrorStates(
            errorMessage: 'Something went wrong of check internet'));
      }
    } catch (e) {
      emit(SaknyCreateUserErrorStates(errorMessage: e.toString()));
    }
  }

  Future<void> userCreate({
    required String name,
    required String email,
    required String phone,
    String? nationalId,
    String? bio,
    required String gender,
    required String birthDate,
    required String uId,
    String? type,
    String? image,
  }) async {
    SaknyUserModel createUserModel = SaknyUserModel(
      email: email,
      phone: phone,
      name: name,
      nationalId: nationalId,
      gender: gender,
      uId: uId,
      type: type,
      bio: 'Write your bio...',
      birthDate: birthDate,
      image:
          'https://cdn2.iconfinder.com/data/icons/gaming-and-beyond-part-2-1/80/User_gray-1024.png',
      isEmailVerified: false,
    );

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(createUserModel.toMap());
      emit(SaknyCreateUserSuccessState());
    } catch (e) {
      emit(SaknyCreateUserErrorStates(errorMessage: e.toString()));
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUpWithGoogle() async {
    emit(SaknySignInLoadingState());
    try {
      final googleAccount = await googleSignIn.signIn();
      final googleAuth = await googleAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);
      userCreate(
        bio: 'Write your bio...',
        name: googleSignIn.currentUser!.displayName.toString(),
        email: googleSignIn.currentUser!.email.toString(),
        phone: 'Please add your phone number!',
        uId: uId.toString(),
        image: googleSignIn.currentUser!.photoUrl,
        birthDate: 'Select your date',
        gender: 'Please chose gender',
      );

      emit(GoogleSignInSuccess(auth.currentUser!.uid));
    } on FirebaseAuthException catch (e) {
      emit(GoogleSignInFailure(e.toString()));
      print(e.toString());
    }
  }

  Future<void> userSignIn({
    required String email,
    required String password,
    context,
  }) async {
    emit(SaknySignInLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SaknySignInSuccessState(uId.toString()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SaknySignInErrorState(error: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(SaknySignInErrorState(
            error: 'Wrong password provided for that user'));
      } else {
        emit(SaknySignInErrorState(error: 'Something went wrong'));
      }
    } catch (e) {
      emit(SaknySignInErrorState(error: e.toString()));
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SaknySignInLoadingState());
    try {
      final googleAccount = await googleSignIn.signIn();
      final googleAuth = await googleAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);
      userCreate(
        bio: 'Write your bio...',
        name: auth.currentUser!.displayName.toString(),
        email: auth.currentUser!.email.toString(),
        phone: auth.currentUser!.phoneNumber ?? 'Please add your phone number',
        uId: uId.toString(),
        gender: 'male',
        image: auth.currentUser!.photoURL,
        birthDate: 'date',
        type: 'User',
        nationalId: 'Please Add your id',
      );

      emit(GoogleSignInSuccess(uId.toString()));
    } catch (e) {
      emit(GoogleSignInFailure(e.toString()));
      print(e.toString());
    }
  }

  // Future<UserCredential> signUpWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
}
