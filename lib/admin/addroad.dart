import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/adminhome.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/models/direction/directionmodel.dart';
import 'package:project/models/direction/directionrep.dart';
import 'package:project/models/direction/location.dart';
import 'package:project/models/road.dart';
import 'package:project/models/schoolmodel.dart';

class AddnewRoad extends StatefulWidget {
  @override
  State<AddnewRoad> createState() => _AddnewRoadState();
}

class _AddnewRoadState extends State<AddnewRoad> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.550679254525768, 31.011754704585183),
    zoom: 17,
  );
  // GoogleMapController? _googleMapController;
  Completer<GoogleMapController> _controller = Completer();
  LatLng? Selected;

  Marker? origin;
  Marker? destination;
  Directions? info;
  late Marker place;
  String? dropdownValue;
  String? dropdownValue2;

  var destController = TextEditingController();
  var sourController = TextEditingController();
  var s = TextEditingController();

  List<Marker> mark = [];
  List<Marker> mark2 = [];
  List<Marker> Allmark = [];

  @override
  void initState() {
    admincubit.get(context).getRoad();
    super.initState();
    getschool();
  }

  @override
  void dispose() {
    // _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: s,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        var place = await locationserves().getplace(s.text);
                        getToPlace(place);
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
      body: Column(
        children: [
          Container(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,

                    items: mark.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.infoWindow.title.toString(),
                        child: Text(value.infoWindow.title.toString()),
                      );
                    }).toList(),
                    // value: dropdownValue,
                    hint: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Your School",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    isDense: true,

                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      // color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        DropdownButtonfunction(newValue!);
                        dropdownValue = newValue;
                        destController.text = newValue;
                      });
                    },
                  ),
                ),
                Container(
                  width: 180,
                  height: 50,
                  child: TextFormField(
                    controller: destController,
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    items: mark2.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.infoWindow.title.toString(),
                        child: Text(value.infoWindow.title.toString()),
                      );
                    }).toList(),
                    // value: dropdownValue,
                    hint: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Your area",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    isDense: true,

                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      // color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        DropdownButtonfunction2(newValue!);
                        dropdownValue2 = newValue;
                        sourController.text = newValue;
                      });
                    },
                  ),
                ),
                Container(
                  width: 180,
                  height: 50,
                  child: TextFormField(
                    controller: sourController,
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          if (origin != null && destination != null)
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () async {
                        getRoad();
                        print("getRoad is done");
                      },
                      child: Text("Get Direction ")),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () async {
                        createRoad(
                            from_lat: origin!.position.latitude,
                            from_long: origin!.position.longitude,
                            to_lat: destination!.position.latitude,
                            to: destination!.infoWindow.title.toString(),
                            from: origin!.infoWindow.title.toString(),
                            to_long: destination!.position.longitude);
                        print("getRoad is done");
                      },
                      child: Text("Set A Road ")),
                ),
              ],
            ),
          Expanded(
            child: GoogleMap(
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
              // zoomGesturesEnabled: false,
              trafficEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _controller.complete(controller),
              markers: Set<Marker>.of(Allmark),
              mapType: MapType.normal,
              polylines: {
                if (info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.lightBlue,
                    width: 3,
                    points: info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getschool() async {
    FirebaseFirestore.instance
        .collection('Schools')
        .snapshots()
        .listen((event) {
      mark = [];
      mark2 = [];
      event.docs.forEach((element) {
        // titles!.add(element.data()['schoolname']);
        print("${element.data()['place']}");
        placeModel.fromjson(element.data());
        mark.add(Marker(
          markerId: MarkerId("${element.data()['place']}"),
          position:
              LatLng(element.data()['place_lat'], element.data()['place_long']),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: '${element.data()['schoolname']}'),
          onTap: () {
            setState(() {
              destController.text = element.data()['schoolname'];
              DropdownButtonfunction(destController.text);
            });
          },
        ));
        setState(() {});
      });
    });
    FirebaseFirestore.instance
        .collection('sources')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        // titles!.add(element.data()['schoolname']);
        placeModel.fromjson(element.data());
        mark2.add(Marker(
          markerId: MarkerId("${element.data()['place']}"),
          position:
              LatLng(element.data()['place_lat'], element.data()['place_long']),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: '${element.data()['schoolname']}'),
          onTap: () {
            setState(() {
              sourController.text = element.data()['schoolname'];
              DropdownButtonfunction2(sourController.text);
            });
          },
        ));
        Allmark.addAll(mark);
        Allmark.addAll(mark2);

        setState(() {});
      });
    });

    setState(() {});
  }

  void getRoad() async {
    final directions = await DirectionsRepository().getDirections(
        origin: origin!.position, destination: destination!.position);
    info = null;
    setState(() => info = directions);
    print(info!.bounds);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(info!.bounds, 100.0));
  }

  Future<void> getToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 20)));
  }

  Future<void> DropdownButtonfunction(String select) async {
    mark.forEach((element) async {
      if (element.infoWindow.title == select) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target:
                LatLng(element.position.latitude, element.position.longitude),
            zoom: 20)));
        destination = element;
        setState(() {});
      }
    });
  }

  Future<void> DropdownButtonfunction2(String select) async {
    mark2.forEach((element) async {
      if (element.infoWindow.title == select) {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target:
                LatLng(element.position.latitude, element.position.longitude),
            zoom: 20)));
        origin = element;
        setState(() {});
      }
    });
  }

  void createRoad({
    required double from_lat,
    required double from_long,
    required double to_lat,
    required double to_long,
    required var to,
    required var from,
  }) async {
    roadmodel model = roadmodel(
        from_lat: from_lat,
        from_long: from_long,
        to_lat: to_lat,
        to: to,
        from: from,
        to_long: to_long);
    int x = 0;
    print(admincubit.get(context).road);
    admincubit.get(context).road.forEach((element) {
      print('siu ${element.from.toString()}');
      if (element.from == from && element.to == to) {
        x = 1;
      }
    });
    if (x == 0) {
      FirebaseFirestore.instance
          .collection('road')
          .doc('$from_lat $to_lat')
          .set(model.TOMap())
          .then((value) {
        print("Done To fire Base");
        ShowToastFun(msg: "Done To fire Base", Sort: toaststate.success);
        Nav(context, adminhome());
      }).catchError((onError) {
        ShowToastFun(msg: "error in fireBase", Sort: toaststate.error);

        print("siu ya siu ");
        print(onError);
      });
    } else {
      ShowToastFun(msg: "Is Alred find It", Sort: toaststate.error);
      Nav(context, adminhome());
    }
  }
}
