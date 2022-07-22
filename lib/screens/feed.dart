import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/livelocation.dart';
import 'package:project/screens/Show.dart';
import 'package:project/admin/showRoad.dart';
import 'package:project/admin/yourcustomer.dart';
import 'package:project/bottomscreen/becomedriver/becameadriver.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';

import '../admin/who.dart';
import '../widgets/action_container_large.dart';
import '../widgets/action_container_small.dart';

class feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print("Uid is ${u_model}");
   

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  if (u_model?.isdriver == false)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          NavegatorPush(context, becameadriverscreen());
                        },
                        child: const ActionContainerLarge(
                          img: 'as/images/suv.png',
                          title: 'Became a Driver',
                        ),
                      ),
                    ),
                  if (u_model?.isdriver == true)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          NavegatorPush(context, yourcustomer());
                        },
                        child: const ActionContainerLarge(
                          img: 'as/images/suv.png',
                          title: 'My Customer',
                        ),
                      ),
                    ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        NavegatorPush(context, who());
                      },
                      child: ActionContainerLarge(
                          img: 'as/images/box.png', title: 'Booking'),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
                            if (u_model?.isdriver == true)
              InkWell(
                onTap: () {
                  NavegatorPush(context, livelocation());
                },
                child: ActionContainerLarge(
                    img: 'as/images/car.png', title: 'Enable Live Location'),
              ),
               const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  origin = null;
                  destination = null;
                  NavegatorPush(context, mapshow());
                },
                child: TextField(
                  enabled: false,
                  autofocus: false,
                  showCursor: false,
                  decoration: InputDecoration(
                      hintText: 'Choose Your School?',
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 24),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              if (homeCubit.get(context).lat != null &&
                  homeCubit.get(context).long != null)
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(homeCubit.get(context).lat,
                            homeCubit.get(context).long),
                        zoom: 15,
                      ),
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      onTap: (i) {
                        origin = null;
                        destination = null;
                        NavegatorPush(context, mapshow());
                      },
                    ),
                  ),
                ),
               // GridView.count(
              //   shrinkWrap: true,
              //   childAspectRatio: 1 / 1.77,
              //   physics: NeverScrollableScrollPhysics(),
              //   crossAxisCount: 3,
              //   mainAxisSpacing: 10,
              //   crossAxisSpacing: 10,
              //   children: [
              //     Container(
              //       color: Colors.teal,
              //       child: TextButton(
              //           onPressed: () {
              //             NavegatorPush(context, becameadriverscreen());
              //           },
              //           child: Text(
              //             "Became a Driver",
              //             style: Theme.of(context).textTheme.bodyLarge,
              //           )),
              //     ),
              //     Container(
              //       color: Colors.tealAccent,
              //       child: TextButton(
              //           onPressed: () {
              //             homeCubit.get(context).getUserData();
              //           },
              //           child: Text(
              //             "Siu ",
              //             style: Theme.of(context).textTheme.bodyLarge,
              //           )),
              //     ),
              //     Container(
              //       color: Colors.teal,
              //       child: TextButton(
              //         onPressed: () {
              //           NavegatorPush(context, mapshow());
              //         },
              //         child: Text(
              //           "GEt A School Ya Ragel ya sIu",
              //           style: Theme.of(context).textTheme.bodyLarge,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
