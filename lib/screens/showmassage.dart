import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/home/Home.dart';
import 'package:project/models/complaintmodel.dart';

class showmassageuser extends StatelessWidget {
  complaintmodel? model;
  showmassageuser({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("complaints"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Row(
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
                          Text("${model!.name}"),
                          Text("${model!.email}",
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                   Spacer(),
                   TextButton(onPressed: (){
                    homeCubit.get(context).deleteComp(uid: model!.Uid, msg: model!.msg).then((value) {
                      Nav(context, Home());
                    });
                   }, child: Text("Delate"))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                                                        color: Colors.blue.withOpacity(0.05),

                      child: Text(
                        "${model!.msg}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
//  Spacer(),
if(model!.adminrep==false)
                  Center(child: Text("Repair work in progress",style:TextStyle(fontSize: 20,),)),
                  
                  if(model!.adminrep==true)
                  Center(child: Text("The admin saw the complaint and will working To solve it",style:TextStyle(fontSize: 12,),)),

                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}