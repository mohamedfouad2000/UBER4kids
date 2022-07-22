import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/cashehelber.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/addSource.dart';
import 'package:project/admin/addadrtoaroad.dart';
import 'package:project/admin/addmarker.dart';
import 'package:project/admin/addnewdriver.dart';
import 'package:project/admin/addroad.dart';
import 'package:project/admin/showcomplaints.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/login/login.dart';

class adminhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return admincubit()..getdrivers();
      },
      child: BlocConsumer<admincubit, adminStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            // drawer: Drawer(
            //   child: SingleChildScrollView(
            //       child: Column(
            //     children: [header(context), MyDrawerList(context)],
            //   )),
            // ),
            appBar: AppBar(),
           
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    NavegatorPush(context, AddnewRoad());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: Center(child: const Text("Add A New Road")),
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavegatorPush(context, addDtoR());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[200],
                    child: Center(child: const Text('Add  A Driver To Road ')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavegatorPush(context, addNewdrivers());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[300],
                    child: Center(child: const Text('Accept Driver')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavegatorPush(context, AddMarker());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[400],
                    child: Center(child: const Text('Set A School')),
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavegatorPush(context, addSource());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[500],
                    child: Center(child: const Text('Set A Sourcs')),
                  ),
                ),
                 InkWell(
                  onTap: () {
                    NavegatorPush(context, Showcomplaints());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[500],
                    child: Center(child: const Text("Show complaints")),
                  ),
                ),
                   InkWell(
                  onTap: () {
                    casheHelber.removeData(key: 'uId').then((value) {
                      Nav(context, loginscreen());
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[600],
                    child: Center(child: const Text('Logout')),
                  ),
                ),
              ],
            ),
            // Column(
            //   children: [
            //     Expanded(
            //       child: TextButton(
            //           onPressed: () {
            //             NavegatorPush(context, AddnewRoad());
            //           },
            //           child: Text("Add A New Road")),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //           onPressed: () {
            //             NavegatorPush(context, addDtoR());
            //           },
            //           child: Text("Add  A Driver To Road ")),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //           onPressed: () {
            //             NavegatorPush(context, addNewdrivers());
            //           },
            //           child: Text("Accept Driver")),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //           onPressed: () {
            //             NavegatorPush(context, AddMarker());
            //           },
            //           child: Text("Set A School")),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //           onPressed: () {
            //             NavegatorPush(context, addSource());
            //           },
            //           child: Text("Set A Sourcs")),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //           onPressed: () {
            //             casheHelber.removeData(key: 'uId').then((value) {
            //               Nav(context, loginscreen());
            //             });
            //           },
            //           child: Text("Logout")),
            //     ),
            //   ],
            // ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
