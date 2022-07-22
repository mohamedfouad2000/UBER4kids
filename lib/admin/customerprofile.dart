import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/models/usermodel.dart';
import 'package:project/screens/edituser.dart';
// import 'package:profile_page/widgets/info_card.dart';

// our data
//  url = "${model!.name}";

class customerprof extends StatelessWidget {
  usermodel? model;
  customerprof({required this.model});
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
                      backgroundImage: NetworkImage("${model!.profile}"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${model!.name}",
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
                        text: "${model!.bio}",
                        icon: Icons.info_outline,
                        onPressed: () async {}),
                    // we will be creating a new widget name info carrd

                    InfoCard(
                        text: "${model!.phone}",
                        icon: Icons.phone,
                        onPressed: () async {}),

                    InfoCard(
                        text: '${model?.gender}',
                        icon: Icons.location_city,
                        onPressed: () async {}),
                    InfoCard(
                        text: '${model!.email}',
                        icon: Icons.email,
                        onPressed: () async {}),
                    SizedBox(
                      height: 20,
                    ),
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
