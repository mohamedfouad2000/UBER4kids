import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/register/registerstates.dart';
import 'package:project/models/usermodel.dart';

class registercubit extends Cubit<register_States> {
  registercubit() : super(Initial_register_state());
  static registercubit get(context) => BlocProvider.of(context);

  IconData password = Icons.remove_red_eye_sharp;
  bool ispassword = true;
  void changePasswordIcon() {
    ispassword = !ispassword;
    password =
        ispassword ? Icons.remove_red_eye_sharp : Icons.remove_red_eye_outlined;
    emit(changePasswordRe());
  }

  void userregister({
    required String email,
    required String password,
    required String phone,
    required String name,
    required String gender,
  }) {
    emit(register_loding_state());
    print("object");
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print("siu login Auth ");
      // print(value.user!.email.toString());
      // print("sIUUUUUUUDashdahsudhasuhduhuhasduhauhsdasjhkdjas");
      // print(value.user!.uid);
      usercreate(
          email: email,
          phone: phone,
          name: name,
          uId: value.user!.uid,
          gender: gender);
    }).catchError((onError) {
        emit(createUser_eroor_state(eroor: onError.toString()));
    });
  }

  void usercreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
    required String gender,
  }) {
    usermodel model = usermodel(
        bio: "",
        profile: gender == 'male'
            ? 'https://cdn-icons-png.flaticon.com/512/219/219986.png'
            : 'https://www.shareicon.net/data/512x512/2016/09/15/829453_user_512x512.png',
        admin: false,
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isemailv: false,
        isdriver: false,
        driverNumber: 0,
        gender: gender);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.TOMap())
        .then((value) {
      emit(createUser_succ_state(uId: uId));
    }).catchError((onError) {
      print(onError.toString());
      emit(createUser_eroor_state(eroor: onError.toString()));
    });
  }
}
