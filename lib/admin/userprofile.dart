import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/screens/edituser.dart';
// import 'package:profile_page/widgets/info_card.dart';

// our data
//  url = "${u_model!.name}";

class userprofile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(),
            drawer: Drawer(
              child: SingleChildScrollView(
                  child: Column(
                children: [header(context), MyDrawerList(context)],
              )),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
                minimum: const EdgeInsets.only(top: 100),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("${u_model!.profile}"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${u_model!.name}",
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.teal,
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Pacifico",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 200,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),

                    InfoCard(
                        text: "${u_model!.bio}",
                        icon: Icons.info_outline,
                        onPressed: () async {}),
                    // we will be creating a new widget name info carrd

                    InfoCard(
                        text: "${u_model!.phone}",
                        icon: Icons.phone,
                        onPressed: () async {}),

                    InfoCard(
                        text: '${u_model?.gender}',
                        icon: Icons.location_city,
                        onPressed: () async {}),
                    InfoCard(
                        text: '${u_model!.email}',
                        icon: Icons.email,
                        onPressed: () async {}),
                    SizedBox(
                      height: 20,
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
                            NavegatorPush(context, editProfile());
                          },
                          child: const Text(
                            "EDIT USER",
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
            ));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  var onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}
