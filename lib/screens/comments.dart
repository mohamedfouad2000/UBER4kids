import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/models/drivermodel.dart';
import 'package:project/models/getcomments.dart';

class comments extends StatelessWidget {
  drivermodel? model;
  comments({required this.model});

  @override
  Widget build(BuildContext context) {
    homeCubit.get(context).getComments(model: model);
    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("comments"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
              builder: (BuildContext context) {
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return com(model:  homeCubit.get(context).com[index]);  },
                  itemCount: homeCubit.get(context).com.length,
                  separatorBuilder: (BuildContext context, int index) {

                      return Container(
                        height: 1,
                        width: double.infinity,
                        // color: Colors.black,
                      );
                  },
                );
              },
              condition: state is getCommentssucc,
              fallback: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
  Widget com({required getCommentss model}){
    if(model.comment==null && model.improvements==null){
      return Container(
        height: 0,
        width: 0,
      );
    }
    else{
           return Padding(
             padding: const EdgeInsets.all(10.0),
             child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.teal,
                          backgroundImage: NetworkImage("${model.Photo}"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              // shape: BoxShape.values[100],
                              color: Colors.blue.withOpacity(0.05),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${model.name}",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),),
                                if(model.comment!=null)
                              Text("${model.comment}",style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                  
                                ),),
                                if(model.improvements!=null)
                               Text("${model.improvements}",style: TextStyle(
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold
                                ),),
                             
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
           );
    }

               }
}
