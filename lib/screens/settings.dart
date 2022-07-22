import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/login/login.dart';

class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          onPressed: () {
            casheHelber.removeData(key: Uid).then((value) {
              Nav(context, loginscreen());
            });
          },
          child: Container(
            width: double.infinity,
            child: const Text(
              "Sing Out ",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          )),
    );
  }
}
