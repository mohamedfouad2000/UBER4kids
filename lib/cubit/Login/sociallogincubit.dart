import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/Login/loginstates.dart';

class Logincubit extends Cubit<Login_States> {
  Logincubit() : super(Initial_state());
  static Logincubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(Login_loding_state());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("Log in Tamam");
      print(value.user!.uid);
      emit(Login_success_state(value.user!.uid));
    }).catchError((onError) {
      print("Error Man In Log iN ");
      emit(Login_Error_state(onError.toString()));
    });
  }

  IconData password = Icons.remove_red_eye_sharp;
  bool ispassword = true;
  void changePasswordIcon() {
    ispassword = !ispassword;
    password =
        ispassword ? Icons.remove_red_eye_sharp : Icons.remove_red_eye_outlined;
    emit(changePassword());
  }
}
