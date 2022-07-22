import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/register/registerstates.dart';
import 'package:project/cubit/register/socailregistercubit.dart';
import 'package:project/home/Home.dart';
import 'package:project/login/login.dart';

class register extends StatelessWidget {
  var usercontrol = TextEditingController();
  var emailcontrol = TextEditingController();
  String genderr = 'male';

  var passwordcontrol = TextEditingController();
  var regkey = GlobalKey<FormState>();

  var phonecontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => registercubit(),
      child: BlocConsumer<registercubit, register_States>(
        builder: (BuildContext context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: regkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Register",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm(
                            Con: usercontrol,
                            lable: "Name",
                            prefixIcon: Icon(Icons.account_box_outlined),
                            val: "Please enter name Again !"),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm(
                            Con: emailcontrol,
                            lable: "email",
                            prefixIcon: Icon(Icons.person),
                            val: "Please enter user Again !"),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm(
                            Con: passwordcontrol,
                            lable: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon:
                                Icon(registercubit.get(context).password),
                            val: "Please enter Password Again !",
                            type: TextInputType.visiblePassword,
                            obscureText: registercubit.get(context).ispassword,
                            fun_su: () {
                              registercubit.get(context).changePasswordIcon();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm(
                            type: TextInputType.phone,
                            Con: phonecontrol,
                            lable: "phone",
                            prefixIcon: Icon(Icons.phone),
                            val: "Please enter phone Again !"),
                        SizedBox(
                          height: 20,
                        ),
                        GenderPickerWithImage(
                          onChanged: (Gender? gender) {
                            if (gender!.index == 0) {
                              genderr = 'male';
                            } else {
                              genderr = 'female';
                            }
                          },

                          verticalAlignedText: false,
                          selectedGender: Gender.Male,
                          equallyAligned: true,
                          animationDuration: Duration(milliseconds: 300),
                          isCircular: true,
                          // default : true,
                          opacityOfGradient: 0.4,
                          padding: const EdgeInsets.all(3),
                          size: 50, //default : 40
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        state is! register_loding_state
                            ? Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: const LinearGradient(
                                      colors: [Colors.blue, Colors.green]),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (regkey.currentState!.validate()) {
                                      registercubit.get(context).userregister(
                                          email: emailcontrol.text,
                                          password: passwordcontrol.text,
                                          phone: phonecontrol.text,
                                          name: usercontrol.text,
                                          gender: genderr);
                                    }
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 30,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "have an Account?",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavegatorPush(context, loginscreen());
                                },
                                child: const Text("Login Page"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
         
          if (state is createUser_succ_state) {
            if (emailcontrol.text == "admin@yahoo.com") {
              casheHelber
                  .setDataShared(key: "uId", value: state.uId)
                  .then((value) {
                Nav(context, adminhome());
              });
            } else {
              casheHelber
                  .setDataShared(key: "uId", value: state.uId)
                  .then((value) {
                Uid = state.uId;
                homeCubit.get(context).getUserData();

                Nav(context, Home());
              });
            }
          }
          if (state is createUser_eroor_state) {
            print("sss");
            print(state.eroor.toString());
            ShowToastFun(
                msg: "${state.eroor.toString().substring(30)}",
                Sort: toaststate.error);
          }
        },
      ),
    );
  }
}
