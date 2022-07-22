import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/drivermodel.dart';
import 'package:project/models/road.dart';

class adddrivertoroad2 extends StatelessWidget {
  roadmodel model1;
  adddrivertoroad2(this.model1);

  var scafKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<admincubit, adminStates>(
      builder: (BuildContext context, state) {
        admincubit.get(context).getdriverNotSet();
        return Scaffold(
          key: scafKey,
          appBar: AppBar(),
          drawer: Drawer(
            child: SingleChildScrollView(
                child: Column(
              children: [header(context), MyDrawerList(context)],
            )),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return driverNotSet(
                      admincubit.get(context).driverNotSet[index], context);
                },
                itemCount: admincubit.get(context).driverNotSet.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    color: Colors.grey[500],
                    height: 2,
                  );
                },
              );
            },
            condition: state is! getdrivernotsetloading,
            fallback: (BuildContext context) {
              // print( admincubit.get(context).driverNotSet.length);
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget driverNotSet(drivermodel model, BuildContext context) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("${model.profile}"),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          Spacer(),
          IconButton(
              onPressed: () {
                // admincubit.get(context).driverNotSet=[];
                Nav(context, adminhome());
                admincubit.get(context).setDriverToRoad(model, context, model1);
              },
              icon: Icon(Icons.add)),
        ],
      );
}
