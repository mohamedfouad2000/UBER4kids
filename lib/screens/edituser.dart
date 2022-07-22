import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/home/Home.dart';
import 'package:project/models/usermodel.dart';

class editProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var usernameContr = TextEditingController();
    var phoneContr = TextEditingController();
    var BioContr = TextEditingController();

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        usernameContr.text = "${u_model!.name}";
        phoneContr.text = "${u_model!.phone}";
        BioContr.text = "${u_model!.bio}";
        var prof = homeCubit.get(context).userprofile;

        ImageProvider profilefun() {
          if (prof == null) {
            return NetworkImage("${u_model!.profile}");
          } else {
            return FileImage(prof);
          }
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.teal,
            ),
          ),
          body: Container(
            color: Colors.white,
            // height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                            radius: 100.0, backgroundImage: profilefun()),
                        const CircleAvatar(
                          radius: 23.0,
                          backgroundColor: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: 1.0,
                            end: 1.0,
                          ),
                          child: IconButton(
                            iconSize: 30,
                            color: Colors.blue,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                            ),
                            onPressed: () {
                              var x = AlertDialog(
                                title: Text(
                                  "Chosse Your Photo",
                                  style: TextStyle(
                                      color: Theme.of(context).backgroundColor),
                                ),
                                content: Container(
                                  height: 140,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: double.infinity,
                                          color:
                                              Theme.of(context).backgroundColor,
                                          child: TextButton.icon(
                                              label: Text(
                                                "Gallary",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                homeCubit
                                                    .get(context)
                                                    .getuserprofile(
                                                        i: ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.storage_outlined,
                                                color: Colors.white,
                                              ))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                          height: 50,
                                          width: double.infinity,
                                          color:
                                              Theme.of(context).backgroundColor,
                                          child: TextButton.icon(
                                              label: Text(
                                                "camera",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                homeCubit
                                                    .get(context)
                                                    .getuserprofile(
                                                        i: ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.sailing,
                                                color: Colors.white,
                                              ))),
                                    ],
                                  ),
                                ),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return x;
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is userprofilePhotoLoading)
                    SizedBox(
                      height: 20,
                    ),
                  if (state is userprofilePhotoLoading)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  if (homeCubit.get(context).userprofile != null)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              color: Colors.teal,
                              // padding: EdgeInsetsGeometry.infinity,
                              child: TextButton(
                                  onPressed: () {
                                    homeCubit.get(context).updateuserprofile(
                                        context: context,
                                        name: usernameContr.text,
                                        phone: phoneContr.text,
                                        bio: BioContr.text);
                                  },
                                  child: Text(
                                    "Update Photo ",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                            controller: usernameContr,
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 20),
                            controller: phoneContr,
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              border: InputBorder.none,
                              prefix: Icon(
                                Icons.phone_android,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: TextFormField(
                            controller: BioContr,
                            style: const TextStyle(fontSize: 20),
                            decoration: const InputDecoration(
                              labelText: 'Bio',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Container(
                      height: 60,
                      width: double.infinity / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.green]),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          homeCubit
                              .get(context)
                              .updateuser(
                                  name: usernameContr.text,
                                  phone: phoneContr.text,
                                  bio: BioContr.text)
                              .then((value) {
                            homeCubit.get(context).userprofile = null;
                            Nav(context, Home());
                          });
                        },
                        child: const Text(
                          "Confirm Edit",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
                child: Column(
              children: [header(context), MyDrawerList(context)],
            )),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
