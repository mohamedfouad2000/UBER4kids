import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/Shared/brocker.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/who.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return homeCubit()
          ..getUserData()
          ..getdrivers()
          ..getallusers()
          ..getloction();
      },
      child: BlocConsumer<homeCubit, HomeStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.amberAccent,
              title: Text(
                homeCubit
                    .get(context)
                    .titles[homeCubit.get(context).currentIndex],
              ),
              
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.white,
              fixedColor: Colors.teal,
              currentIndex: homeCubit.get(context).currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: "home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Search), label: "search"),
              ],
              onTap: (index) {
                homeCubit.get(context).changeIcon(index);
              },
            ),
            body: homeCubit
                .get(context)
                .Screens[homeCubit.get(context).currentIndex],
            drawer: Drawer(
              child: SingleChildScrollView(
                  child: Column(
                children: [header(context), MyDrawerList(context)],
              )),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          //  if(state is Post_state){
          //    NavegatorPush(context, Post());
          //  }
        },
      ),
    );
  }
}
