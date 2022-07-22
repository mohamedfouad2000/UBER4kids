import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/home/Home.dart';
import 'package:project/models/direction/location.dart';
import 'package:project/models/schoolmodel.dart';

List<Marker> mymark2 = [];

class AddMarker extends StatelessWidget {
  List<Placemark> placemarks = [];
  LatLng? _latLng;
  var nameco = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var s = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();
// ignore: prefer_final_fields
  var _initialCameraPosition = const CameraPosition(
    target: LatLng(30.5524505218059, 31.01366493305248),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<admincubit, adminStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: s,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Theme.of(context).backgroundColor,
                          ),
                          onPressed: () async {
                            var place = await locationserves().getplace(s.text);
                            getToPlace(place, _controller);
                          },
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            s.text = '';
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                )),
            // actions: [

            //   // TextButton(
            //   //     onPressed: () async {
            //   //       siu();
            //   //       print("siu is done");
            //   //     },
            //   //     child: Icon(Icons.dangerous)),

            // ],
          ),
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (LatLng l) {
                  mymark2 = [];
                  print("lat long is  $l");
                  _latLng = l;
                  admincubit.get(context).addMarker2(l);
                },
                markers: Set.from(mymark2),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var di = AlertDialog(
                content: Container(
                  height: 150,
                  child: Column(
                    children: [
                      Form(
                        key: formkey,
                        child: Container(
                          child: TextForm(
                              Con: nameco,
                              lable: "enter Name Of School ",
                              prefixIcon: Icon(Icons.bus_alert),
                              val: "Enter Please"),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await setLocation(
                                      _latLng!.latitude, _latLng!.longitude)
                                  .then((value) {
                                admincubit
                                    .get(context)
                                    .createmarker(
                                        place_lat: _latLng!.latitude,
                                        place_long: _latLng!.longitude,
                                        place: placemarks[0].name,
                                        schoolname: nameco.text,
                                        Street: placemarks[0].street,
                                        Country: placemarks[0].country,
                                        Locality: placemarks[0].locality)
                                    .then((value) {
                                  Nav(context, adminhome());
                                });
                              });
                              print(nameco.text);
                            }
                          },
                          child: Text("Add to Data Base"))
                    ],
                  ),
                ),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return di;
                },
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  Future setLocation(x, y) async {
    placemarks = [];
    placemarks = await placemarkFromCoordinates(x, y);
    print(placemarks[0]);
  }

  Future<void> getToPlace(Map<String, dynamic> place, contr) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await contr.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 20)));
  }
}
