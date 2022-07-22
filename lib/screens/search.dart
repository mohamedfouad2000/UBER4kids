import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/screens/profile.dart';

import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';

class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  if (value == "") {
                    homeCubit.get(context).empty(value);
                  } else {
                    homeCubit.get(context).runFilter(value);
                  }
                },
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search,),),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: homeCubit.get(context).FoundDriver.isNotEmpty
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: homeCubit.get(context).FoundDriver.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            homeCubit.get(context).setprofil(
                                homeCubit.get(context).FoundDriver[index]);
                            NavegatorPush(
                                context,
                                profile(
                                    model: homeCubit
                                        .get(context)
                                        .FoundDriver[index]));
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                      "${homeCubit.get(context).FoundDriver[index].profile}"),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${homeCubit.get(context).FoundDriver[index].name}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (homeCubit
                                              .get(context)
                                              .FoundDriver[index]
                                              .rate !=
                                          0)
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                      if (homeCubit
                                              .get(context)
                                              .FoundDriver[index]
                                              .rate !=
                                          0)
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20.0,
                                        ),
                                      if (homeCubit
                                              .get(context)
                                              .FoundDriver[index]
                                              .rate !=
                                          0)
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                      if (homeCubit
                                              .get(context)
                                              .FoundDriver[index]
                                              .rate !=
                                          0)
                                        Text(
                                          "${homeCubit.get(context).FoundDriver[index].rate.toString().substring(0, 3)}",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.grey,
                                              letterSpacing: 2.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "from :${homeCubit.get(context).FoundDriver[index].from}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[650]),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "to :${homeCubit.get(context).FoundDriver[index].to}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[650]),
                                  ),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                       ),
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey,
                          );
                        },
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
