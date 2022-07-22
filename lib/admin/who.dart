import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/screens/profile.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/models/drivermodel.dart';

class who extends StatelessWidget {
  // const who({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeCubit.get(context).getDriverOfUSer();
    print(homeCubit.get(context).UseroFdriver!.length);

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Drivers of you"),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
               if( homeCubit.get(context).UseroFdriver!.isNotEmpty){
  return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                  
                    return whoo(
                        homeCubit.get(context).UseroFdriver![index], context);
                  },
                  itemCount: homeCubit.get(context).UseroFdriver!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      height: 1,
                      color: Theme.of(context).backgroundColor,
                    );
                  },
                ),
              );
         
               }
               else{
                return Center(child: Text("Not booked with a driver"),);
               }
               },
            condition: state is! getDriverOfUSerloading,
            fallback: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
                child: Column(
              children: [header(context), MyDrawerList(context)],
            )),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget whoo(drivermodel model, BuildContext context) => InkWell(
        onTap: () {
          NavegatorPush(context, profile(model: model));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${model.profile}"),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${model.name}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "${model.bio}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[650]),
                ),
              ],
            ),
          ],
        ),
      );
}
