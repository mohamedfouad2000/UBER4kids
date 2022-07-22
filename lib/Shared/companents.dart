import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Shared/brocker.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/admin/userprofile.dart';
import 'package:project/home/Home.dart';
import 'package:project/login/login.dart';
import 'package:project/models/usermodel.dart';
import 'package:project/screens/contactus.dart';
import 'package:project/screens/yourcomplaints.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/usermodel.dart';

NavegatorPush(context, page) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (builder) => page),
  );
}

Nav(context, page) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (builder) => page), (route) => false);
}

Widget TextForm({
  // ignore: non_constant_identifier_names
  required var Con,
  var type = TextInputType.text,
  var lable,
  var prefixIcon,
  @required var val,
  var obscureText = false,
  var suffixIcon,
  var fun_su,
  var ontap,
  var onchange,
  var onsubmit,
  var enable = true,
}) =>
    TextFormField(
      enabled: enable,
      onFieldSubmitted: onsubmit,
      onTap: ontap,
      controller: Con,
      onChanged: onchange,
      keyboardType: type,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: lable,
        border: const OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: fun_su, icon: suffixIcon)
            : null,
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return val;
        } else {
          return null;
        }
      },
    );

enum toaststate { error, success, warning }

Color ToastSort(toaststate state) {
  Color color;
  switch (state) {
    case toaststate.success:
      color = Colors.green;
      break;
    case toaststate.error:
      color = Colors.red;
      break;
    case toaststate.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}

void ShowToastFun({required String msg, required toaststate Sort}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ToastSort(Sort),
        textColor: Colors.white,
        fontSize: 16.0);
// Widget defalutAppbar({required var context, var title,var Action}) =>
//     AppBar(
//       leading: IconButton(onPressed: (){
//         Navigator.pop(context);
//       }, icon: Icon(IconBroken.Arrow___Left_2)),
//       title: Text("${title}"),
//       actions: Action,
//       );

// Map<PolylineId, Polyline> foUusSh = {};

var Uid;
int pn = 0;
usermodel? u_model;
List<usermodel>? allusers = [];

//  usermodel? u_model;

void contactViaWhatsApp(
    {required context,
    required String phoneNumber,
    required String description}) async {
  String whatsAppUrl = "";

  if (Platform.isIOS) {
    whatsAppUrl =
        'whatsapp://wa.me/$phoneNumber/?text=${Uri.parse(description)}';
  } else {
    whatsAppUrl = 'https://wa.me/+$phoneNumber?text=${Uri.parse(description)}';
  }

  if (await canLaunch(whatsAppUrl)) {
    await launch(whatsAppUrl);
  } else {
    final snackBar = SnackBar(
      content: Text("Install WhatsApp First Please"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Widget MyDrawerList(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(
      children: [
        menuItem(1, 'Home', Icons.home_outlined, context),
        menuItem(2, 'Service', Icons.home_repair_service_outlined, context),
        menuItem(3, 'yourcomplaints', Icons.report_off_sharp, context),
        menuItem(4, 'settings', Icons.settings_outlined, context),
        menuItem(5, 'contacts', Icons.people_alt_outlined, context),
        menuItem(6, 'Log Out', Icons.logout, context),
      ],
    ),
  );
}

Widget menuItem(int id, String title, IconData icon, context) {
  return Material(
    child: InkWell(
      onTap: () {
        if (id == 1) {
          if (u_model!.admin)
            Nav(context, adminhome());
          else {
            Nav(context, Home());
          }
        }
        
        if (id == 5) {
        NavegatorPush(context, ContactUS());
        }

        if (id == 6) {
          casheHelber.removeData(key: 'uId').then((value) {
            Nav(context, loginscreen());
          });
        }
        if(id==3){
            NavegatorPush(context, yourcomplaints());

          
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20.0,
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget header(context) => Container(
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                NavegatorPush(context, userprofile());
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                height: 90.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "${u_model?.profile}",
                  ),
                ),
              ),
            ),
            Text(
              '${u_model?.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              '${u_model?.email}',
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
