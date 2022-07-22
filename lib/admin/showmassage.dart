import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/complaintmodel.dart';

class showmassage extends StatelessWidget {
  complaintmodel? model;
  showmassage({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<admincubit, adminStates>(
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
                  Container(
                    color: Colors.teal,
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                        admincubit.get(context).Adminreplayofcomp(msq: model!.msg,uid: model!.Uid).then((value) {
                          Nav(context, adminhome());
                        });
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
           
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
