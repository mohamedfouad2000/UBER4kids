import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/models/complaintmodel.dart';
import 'package:project/screens/showmassage.dart';

class yourcomplaints extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    homeCubit.get(context).getcompOfuser();
    return BlocConsumer<homeCubit,HomeStates>(
      builder: (BuildContext context, state) {
        return  Scaffold(
            appBar: AppBar(
              title: Text("complaints"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConditionalBuilder(
                builder: (BuildContext context) {
                  if( homeCubit.get(context).compOfuser.isNotEmpty){
                  return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                
                return comp(model: homeCubit.get(context).compOfuser[index],context: context);
               
              },
              itemCount: homeCubit.get(context).compOfuser.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 4,
                  // color: Colors.grey,
                  width: double.infinity,
                
                );
              },
          );
           } else   { return    Center(child: Text("No complaints Of You"),);}
               
                },
                condition: state is getcomplaintssucc,
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
                NavegatorPush(context, showmassageuser(model: model));
              }, child: Text("Show Massage",style: TextStyle(fontSize: 12),), ),
            ),
            

          ],
        ),
  );


}
