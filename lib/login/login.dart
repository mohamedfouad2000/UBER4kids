import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/Login/loginstates.dart';
import 'package:project/cubit/Login/sociallogincubit.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/home/Home.dart';
import 'package:project/register/register.dart';

class loginscreen extends StatelessWidget {
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return Logincubit();
      },
      child: BlocConsumer<Logincubit, Login_States>(
        builder: (BuildContext context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(18),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const Text(
                          "Uber4Kids",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextForm(
                            Con: userController,
                            lable: "User Name",
                            prefixIcon: Icon(Icons.person),
                            val: "Please enter User Again !"),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextForm(
                            Con: passwordController,
                            lable: "Password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Logincubit.get(context).password),
                            val: "Please enter Password Again !",
                            type: TextInputType.visiblePassword,
                            obscureText: Logincubit.get(context).ispassword,
                            fun_su: () {
                              Logincubit.get(context).changePasswordIcon();
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        state is! Login_loding_state
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
                                    if (formkey.currentState!.validate()) {
                                      Logincubit.get(context).userLogin(
                                          email: userController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
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
                              "Don't have an Account?",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  NavegatorPush(context, register());
                                },
                                child: const Text("Register Account"))
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
          if (state is Login_Error_state) {
            ShowToastFun(
                msg: "${state.error.substring(30)}", Sort: toaststate.error);
          }
          if (state is Login_success_state) {
            if (userController.text == 'admin@yahoo.com' &&
                passwordController.text == '1234554321') {
              casheHelber
                  .setDataShared(key: "uId", value: state.uId)
                  .then((value) {
                Nav(context, adminhome());
              });
            } else
              casheHelber
                  .setDataShared(key: "uId", value: state.uId)
                  .then((value) {
                print(value);
                Uid = state.uId;
                //  u_model=value;
                homeCubit.get(context).getUserData();
                Nav(context, Home());
                print(Uid!);
              });
          }
        },
      ),
    );
  }
}
