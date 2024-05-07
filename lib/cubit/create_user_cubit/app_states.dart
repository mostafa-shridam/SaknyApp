
import 'package:sakny/models/user_model.dart';

abstract class SaknyCreateUserStates {}

class SaknyInitialStates extends SaknyCreateUserStates {}

class BottomNavInitialStates extends SaknyCreateUserStates {}

class SaknySignInLoadingState extends SaknyCreateUserStates {}

class SaknySignInSuccessState extends SaknyCreateUserStates {
  final String uId;

  SaknySignInSuccessState(this.uId);
}

class SaknySignInErrorState extends SaknyCreateUserStates {
  final String error;

  SaknySignInErrorState({required this.error});
}

class GoogleSignInSuccess extends SaknyCreateUserStates {
  final String uId;

  GoogleSignInSuccess(this.uId);
}

class GoogleSignInFailure extends SaknyCreateUserStates {
  final String errorMessage;

  GoogleSignInFailure(this.errorMessage);
}

class SaknySignupLoadingState extends SaknyCreateUserStates {}

class SaknyGetUsersLoadingState extends SaknyCreateUserStates {}

class SaknyGetUsersSuccessState extends SaknyCreateUserStates {}

class SaknyGetUsersErrorState extends SaknyCreateUserStates {
  final String error;

  SaknyGetUsersErrorState(this.error);
}

class SaknySignupSuccessState extends SaknyCreateUserStates {}

class SaknyCreateUserSuccessState extends SaknyCreateUserStates {}

class SaknyCreateUserErrorStates extends SaknyCreateUserStates {
  final String errorMessage;

  SaknyCreateUserErrorStates({required this.errorMessage});
}

class GoogleRegistrationSuccess extends SaknyCreateUserStates {}

class GoogleRegistrationFailure extends SaknyCreateUserStates {
  final String errorMessage;

  GoogleRegistrationFailure(this.errorMessage);
}

class SaknyUserLoadedState extends SaknyCreateUserStates {}

class SaknyUserLoadedSuccessState extends SaknyCreateUserStates {
  SaknyUserLoadedSuccessState(SaknyUserModel userModel);
}

class SaknyUserLoadedErrorState extends SaknyCreateUserStates {
  SaknyUserLoadedErrorState(_, String s);
}

class CheckUser extends SaknyCreateUserStates {}
