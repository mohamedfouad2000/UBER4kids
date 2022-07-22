import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/showmassage.dart';
import 'package:project/cubit/admincubit/admincubit.dart';

import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/complaintmodel.dart';

class Showcomplaints extends StatelessWidget {
  // const Showcomplaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    admincubit.get(context).getcomp();
    return BlocConsumer<admincubit, adminStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text("complaints"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConditionalBuilder(
                builder: (BuildContext context) {
                  return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return comp(model: admincubit.get(context).compla[index],context: context);
              },
              itemCount: admincubit.get(context).compla.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 4,
                  // color: Colors.grey,
                  width: double.infinity,
                
                );
              },
          );
                },
                condition: state is compsucc,
                fallback: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Widget comp({required complaintmodel model,context}) => Container(

    decoration: BoxDecoration(
                                   color: Colors.blue.withOpacity(0.05),

      // border:Border.all() 
    ),
    child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.teal,
              backgroundImage: AssetImage("as/images/u22.png"),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${model.name}"),
                Text("${model.email}",style: TextStyle(fontSize: 12),),
              ],
              
            ),
            Spacer(),
            Expanded(
              child: TextButton(onPressed: (){
                NavegatorPush(context, showmassage(model: model));
              }, child: Text("Show Massage",style: TextStyle(fontSize: 12),), ),
            ),
            

          ],
        ),
  );


}
