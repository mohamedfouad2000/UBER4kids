import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/screens/Show.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/models/direction/directionmodel.dart';
import 'package:project/models/direction/directionrep.dart';
import 'package:project/models/drivermodel.dart';

Directions? infoo;
List<Marker> markes = [];

class showRoad extends StatelessWidget {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.550679254525768, 31.011754704585183),
    zoom: 15,
  );
  Completer<GoogleMapController> controllerr = Completer();

  drivermodel? model;
  showRoad({required this.model});

  @override
  Widget build(BuildContext context) {
    homeCubit.get(context).setprofil(model!);
    homeCubit.get(context).getRoadofShowing(cont: controllerr);
    // homeCubit.get(context).getRoad(cont: controllerr);
    // markes!.add(homeCubit.get(context).profileor!);
    // markes!.add(homeCubit.get(context).profildi!);

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          buildingsEnabled: false,
          indoorViewEnabled: false,
          liteModeEnabled: false,
          mapToolbarEnabled: false,
          rotateGesturesEnabled: false,
          // scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomGesturesEnabled: false,
          trafficEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => controllerr.complete(controller),
          markers: Set<Marker>.of(markes),
          mapType: MapType.normal,
          polylines: {
            if (infoo != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.lightBlue,
                width: 3,
                points: infoo!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
