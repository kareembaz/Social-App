import 'package:chat/moduls/login/cubit/login_state.dart';
import 'package:chat/shared/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginSates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uId = value.user!.uid;

      emit(LoginISuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffic = Icons.remove_red_eye_sharp;
  bool ispassWord = true;
  void changePasswordVisility() {
    ispassWord = !ispassWord;
    suffic = ispassWord ? Icons.remove_red_eye_sharp : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }
}
