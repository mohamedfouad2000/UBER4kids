import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/addNewdrivers2.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/drivermodel.dart';

class addNewdrivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    admincubit.get(context).di();

    return BlocConsumer<admincubit, adminStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Accept the Driver"),
            ),
            body: ConditionalBuilder(
              builder: (BuildContext context) {
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return building(context, admincubit.get(context).d[index]);
                  },
                  itemCount: admincubit.get(context).d.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black,
                    );
                  },
                );
              },
              condition: state is! getDloading,
              fallback: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            ));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget building(context, drivermodel model) => InkWell(
        onTap: () {
          NavegatorPush(
              context,
              addNewdrivers2(
                m: model,
              ));
        },
        child: Row(
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
                  // print(admincubit.get(context).d[index].uId);
                  admincubit.get(context).Updatedriverworker(uid: model.uId).then((value) {
                    ShowToastFun(msg: "Add Driver Done", Sort: toaststate.success);
                    Nav(context, adminhome());
                  });
                  // admincubit.get(context).di();
                },
                icon: Icon(Icons.done_outline_sharp)),
          ],
        ),
      );
}
