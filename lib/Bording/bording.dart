import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/login/login.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoarderModel {
  String image;
  String title;
  String body;
  BoarderModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class bording extends StatefulWidget {
  @override
  State<bording> createState() => _bordingState();
}

class _bordingState extends State<bording> {
  var page_Controller = PageController();

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(
              fontSize: 29, color: Colors.white, fontWeight: FontWeight.bold),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                casheHelber
                    .setDataShared(key: "bording", value: true)
                    .then((value) {
                  Nav(context, loginscreen());
                });
              },
              icon: Icon(Icons.navigate_next_rounded),
              iconSize: 30,
            )
          ],
        ),
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            color: Colors.teal,
            child: Column(
              children: [
                const Text(
                  "Uber4Kids",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Image(
                    image: AssetImage('as/images/bus.jpg'),
                  ),
                ),
                Expanded(
                  child: const Text(
                    "Rest assured of safety of your children",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
