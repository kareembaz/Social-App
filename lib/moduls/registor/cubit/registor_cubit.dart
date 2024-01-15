import 'package:chat/model/user_model.dart';
import 'package:chat/moduls/registor/cubit/registor_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistorCubit extends Cubit<RegistorStates> {
  RegistorCubit() : super(RegistorInitialState());
  static RegistorCubit get(context) => BlocProvider.of(context);

//  هنا يتم استقبال من الموديل
  void userregistor({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(registorLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );

      // emit(registorSccessState());
    }).catchError((error) {
      emit(registoreErorrState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        bio: 'Write you bio .....',
        isEmailVerified: false,
        coverImage:
            'https://as2.ftcdn.net/v2/jpg/01/23/64/51/1000_F_123645179_dLlnMCblqGD3KslVMM8oTEOzVJVSKk6n.jpg',
        image:
            'https://as1.ftcdn.net/v2/jpg/02/24/55/24/1000_F_224552423_Lop9QEpyoNZt3g1lwuSEplESt1NTbfOm.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSccessState());
    }).catchError((error) {
      emit(CreateUserErorrState(error));
    });
  }

  IconData suffic = Icons.remove_red_eye_sharp;
  bool ispassWord = true;
  void changePasswordVisility() {
    ispassWord = !ispassWord;
    suffic = ispassWord ? Icons.remove_red_eye_sharp : Icons.visibility_off;
    emit(showRegistorPasswordState());
  }
}
