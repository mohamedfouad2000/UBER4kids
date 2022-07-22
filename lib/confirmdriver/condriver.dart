import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';

class confirmornotDriver extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit,HomeStates>(builder: (BuildContext context, state) { return
    
     Scaffold(
      appBar: AppBar(),
      body:
       Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Container(
          child: Text("Please Wait the Admin to check Your Data",style: TextStyle(
            fontSize: 20,
          ),),
          
            ),
        ),
      )
    );
    ;
    
    }, 
    listener: (BuildContext context, Object? state) {  },);
  }
}