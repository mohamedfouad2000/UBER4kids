import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/AddDriverToRoad2.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/drivermodel.dart';
import 'package:project/models/road.dart';

class addDtoR extends StatelessWidget {
  var scafKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    admincubit.get(context).getRoad();
    return BlocConsumer<admincubit, adminStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          key: scafKey,
          appBar: AppBar(),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return page(admincubit.get(context).road[index], context);
                },
                itemCount: admincubit.get(context).road.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    color: Colors.grey[500],
                    height: 2,
                  );
                },
              );
            },
            condition: state is! getroadloading,
            fallback: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget page(roadmodel model, BuildContext context) => InkWell(
        onTap: () {
          NavegatorPush(context, adddrivertoroad2(model));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text("From :"),
                Text("${model.from}"),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text("To :"),
                Text("${model.to}"),
              ],
            ),
          ],
        ),
      );
}
