import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/addSource.dart';
import 'package:project/admin/addmarker.dart';
import 'package:project/cubit/admincubit/adminstates.dart';
import 'package:project/models/complaintmodel.dart';
import 'package:project/models/drivermodel.dart';
import 'package:project/models/road.dart';
import 'package:project/models/schoolmodel.dart';
import 'package:project/models/usermodel.dart';

class admincubit extends Cubit<adminStates> {
  admincubit() : super(admin_Initial_state());
  static admincubit get(context) => BlocProvider.of(context);
  List<drivermodel> drivers = [];
  List<roadmodel> road = [];
  List<drivermodel> driverNotSet = [];

  void getdrivers() {
    drivers = [];
    emit(getdriverloading());
    print("siu");
    FirebaseFirestore.instance
        .collection("drivers")
        .get()
        .then((value) => value.docs.forEach((element) {
              drivers.add(drivermodel.fromjson(element.data()));
            }))
        .then((value) {})
        .catchError((onError) {
      print(onError);
      emit(getdrivereroor());
    });
    emit(getdriversucc());
  }

 Future <void> Updatedriverworker({required uid}) async{
    emit(updateGetdriverloading());
    FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .update({'worker': true}).then((value) {
      emit(updateGetdriversucc());
      getdrivers();

      print('Update done');
    }).catchError((onError) {
      emit(updateGetdrivereroor());
    });
  }

  List<drivermodel> d = [];
  void di() {
    d = [];
    emit(getDloading());
   drivers.forEach((element) { 
    if(element.worker==false){
      d.add(element);
    }
   });

    // print("drivers.length");
    // print(drivers.length);
    // drivers.forEach((element) {
    //   if (element.worker == false) {
    //     d.add(element);
    //     // print("siu ");
    //   }
    // });
    emit(getDsucc());
  }

  Future<void> getRoad() async {
    road = [];
    emit(getroadloading());
    print("siu");
    FirebaseFirestore.instance
        .collection("road")
        .get()
        .then((value) => value.docs.forEach((element) {
              road.add(roadmodel.fromjson(element.data()));
              print("asdsadkoofjidfjijiogdjifg");

              emit(getroadsucc());
            }))
        .catchError((onError) {
      print(onError);
      emit(getroaderoor());
    });
  }

  void getdriverNotSet() {
    driverNotSet = [];
    emit(getdrivernotsetloading());
    drivers.forEach((element) {
      if (element.isset == false && element.worker == true) {
        driverNotSet.add(element);
        // print(driverNotSet.length);
      }
    });
    getdrivers();
    emit(getdrivernotsetsucc());
  }

  void Updatedriverisset({required uid, required from, required to}) {
    emit(Updatedriverissetloading());
    FirebaseFirestore.instance.collection('drivers').doc(uid).update({
      'isset': true,
      'from': from,
      'to': to,
    }).then((value) {
      print('update Done');
      emit(Updatedriverissetsucc());
    }).catchError((onError) {
      print('update Don"t Done');

      emit(Updatedriverisseteroor());
    });
    // getdriverNotSet();
  }

  void setDriverToRoad(drivermodel m, context, roadmodel model) {
    // print(m.uId);
    FirebaseFirestore.instance
        .collection('drivers')
        .doc(m.uId)
        .collection('road')
        .doc('${model.from_lat} ${model.to_lat}')
        .set(model.TOMap())
        .then((value) {});
    Updatedriverisset(uid: m.uId, from: model.from, to: model.to);
  }

  Future createmarker({
    required place_lat,
    required place_long,
    required place,
    required schoolname,
    required Street,
    required Country,
    required Locality,
  }) async {
    emit(createmarkerloading());
    placeModel model = placeModel(
        place_lat: place_lat,
        place_long: place_long,
        place: place,
        schoolname: schoolname,
        Street: Street,
        Country: Country,
        Locality: Locality);
    FirebaseFirestore.instance
        .collection('sources')
        .doc('${place_lat}${place_long}')
        .set(model.TOMap())
        .then((value) {
      print("Done To fire Base");
      emit(createmarkersucc());
      ShowToastFun(msg: "Done createSchool ", Sort: toaststate.success);
    }).catchError((onError) {
      print("siu ya siu ");
      print(onError);
      emit(createmarkereroor());
      ShowToastFun(msg: "Eroor ", Sort: toaststate.error);
    });
  }

  void addMarker(l) {
    emit(addMarkerloading());

    mymark.add(Marker(
        markerId: MarkerId(l.toString()),
        position: l,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)));
    emit(addMarkersucc());
  }

  Future createSchool({
    required place_lat,
    required place_long,
    required place,
    required schoolname,
    required Street,
    required Country,
    required Locality,
  }) async {
    emit(createmarkerloading());
    placeModel model = placeModel(
        place_lat: place_lat,
        place_long: place_long,
        place: place,
        schoolname: schoolname,
        Street: Street,
        Country: Country,
        Locality: Locality);
    FirebaseFirestore.instance
        .collection('sources')
        .doc('${place_lat}${place_long}')
        .set(model.TOMap())
        .then((value) {
      print("Done To fire Base");
      emit(createmarkersucc());
      ShowToastFun(msg: "Done createSchool ", Sort: toaststate.success);
    }).catchError((onError) {
      // print("siu ya siu ");
      print(onError);
      emit(createmarkereroor());
      ShowToastFun(msg: "Eroor ", Sort: toaststate.error);
    });
  }

  void addMarker2(l) {
    emit(addMarkerloading());

    mymark2.add(Marker(
        markerId: MarkerId(l.toString()),
        position: l,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)));
    emit(addMarkersucc());
  }

List<complaintmodel>  compla=[];
void getcomp(){
  emit(comploading());
  compla=[];
   FirebaseFirestore.instance
        .collection('complaints').get().then((value)  {
         value.docs.forEach((element) {
          if(element['adminrep']==false)
          compla.add(complaintmodel.fromjson(element.data()));
          });

        }).then((value)  {
  emit(compsucc());
     

        }).catchError((onError){
  emit(comperoor());

        });


        
}
Future<void> Adminreplayofcomp({var uid,var msq})async{
  emit(AdminShocomploading());
  String id;
 FirebaseFirestore.instance.collection('complaints').get().then((value) {
 value.docs.forEach((element) { 
 if(element['Uid']==uid && element['msg']==msq){
  id=element.id;
FirebaseFirestore.instance.collection('complaints').doc(id).update({"adminrep":true});
 }
  
 });
 }).then((value) =>   emit(AdminShocompsucc())
).catchError((onError)=>emit(AdminShocomperoor()));

}



 

}
