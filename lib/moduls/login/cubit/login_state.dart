abstract class LoginSates {}

class LoginInitialState extends LoginSates {}

class LoginLoadingState extends LoginSates {}

class LoginISuccessState extends LoginSates {
  final String UId;

  LoginISuccessState(this.UId);
}

class LoginErrorState extends LoginSates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginSates {}
