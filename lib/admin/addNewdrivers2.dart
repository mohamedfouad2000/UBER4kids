import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/drivermodel.dart';

class addNewdrivers2 extends StatelessWidget {
 drivermodel?  m;
  addNewdrivers2({
  required  this. m,
  });
  @override
  Widget build(BuildContext context) {
    return     BlocProvider(
      create: (BuildContext context) { return admincubit()..getdrivers(); },
      child: BlocConsumer<admincubit, adminStates>(
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Driver Info"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "${m!.profile}"),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${m!.name}",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "${m!.bio}",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey[650]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: Image(image: NetworkImage("${m!.c_chip}"),height: 200,width: 200,) ,
                      ),
                      SizedBox(height: 10,),
                       Container(
                        height: 250,
                        width: double.infinity,
                        child: Image(image: NetworkImage("${m!.back}")) ,
                      ),
                      SizedBox(height: 10,),
                       Container(
                        height: 250,
                        width: double.infinity,
                        child: Image(image: NetworkImage("${m!.front}")) ,
                      ),
                      SizedBox(height: 10,),
                       Container(
                        height: 250,
                        width: double.infinity,
                        child: Image(image: NetworkImage("${m!.licence}")) ,
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),  
                ),
              ),
            );
          },
          listener: (BuildContext context, Object? state) {},
        ),
    );
    
  }
}