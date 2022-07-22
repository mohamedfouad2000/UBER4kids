import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/admin/showRoad.dart';
import 'package:project/cubit/admincubit/admincubit.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/home/Home.dart';
import 'package:project/livelocation.dart';
import 'package:project/models/drivermodel.dart';
import 'package:project/screens/aly.dart';
import 'package:project/screens/comments.dart';
import 'package:project/screens/feed.dart';
import 'package:project/screens/rating.dart';
import 'package:project/screens/siu.dart';

class profile extends StatelessWidget {
  drivermodel model;
  profile({required this.model});
  int number = 0;

  @override
  Widget build(BuildContext context) {
    homeCubit.get(context).checkRequest(m: model, context: context);
    homeCubit.get(context).setprofil(model);
    homeCubit.get(context).getUserData();

    // homeCubit.get(context).getprofiledata(model);
    print(homeCubit.get(context).isRequest);

    return BlocConsumer<homeCubit, HomeStates>(
      builder: (BuildContext context, state) {
        // print("siusiusua uisuidasuidui uiuia ${model.cuurent} ");
        return Scaffold(
  
            appBar: AppBar(),
            drawer: Drawer(
              child: SingleChildScrollView(
                  child: Column(
                children: [header(context), MyDrawerList(context)],
              )),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                  child: ConditionalBuilder(
                builder: (BuildContext context) {
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 140,
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("${model.profile}"),
                              radius: 60.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${model.name}",
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.blueGrey,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w400),
                          ),
                          if (model.rate != 0)
                            SizedBox(
                              width: 5.0,
                            ),
                          if (model.rate != 0)
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 25.0,
                            ),
                          if (model.rate != 0)
                            SizedBox(
                              width: 5.0,
                            ),
                          if (model.rate != 0)
                            Text(
                              "${model.rate.toString().substring(0, 3)}",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w400),
                            ),
                        ],
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${model.bio}",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " From ${model.from} ",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " To ${model.to} ",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Phone ${model.phone}",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // await homeCubit.get(context).setprofil(model);
                          NavegatorPush(
                              context,
                              showRoad(
                                model: model,
                              ));
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            elevation: 2.0,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                child: Text(
                                  "Show A Road",
                                  style: TextStyle(
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300),
                                ))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "People ${model.cuurent} /${model.n_o_passengers}",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
    
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  openRatingDialog(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.withOpacity(0.1),
                                  ),
                                ),
                                icon: Icon(Icons.star),
                                label: Text(
                                  'Rate us!',
                                  style: Theme.of(context).textTheme.headline6,
                                )),
                     Spacer(),
                         TextButton.icon(
                            onPressed: () {
                            NavegatorPush(context, comments(model: model,));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blue.withOpacity(0.1),
                              ),
                            ),
                            icon: Icon(Icons.comment),
                            label: Text(
                              'Comments',
                              style: Theme.of(context).textTheme.headline6,
                            )),
                 
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            NavegatorPush(
                                context,
                                ali(
                                  model: model,
                                ));
                          },
                          child: Text("Tracking")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              contactViaWhatsApp(
                                  context: context,
                                  phoneNumber: '+2${model.phone}',
                                  description: 'Hy Man ');
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.blue, Colors.green]),
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 150.0,
                                  maxHeight: 40.0,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Contact me",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                          // if (model.isset == true)
                          homeCubit.get(context).isRequest != true
                              ? InkWell(
                                  onTap: () {
                                    var x = AlertDialog(
                                        title: Text(
                                          "Chosse The Number Of Child",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        content: model.n_o_passengers -
                                                    model.cuurent !=
                                                0
                                            ? Container(
                                                height: 140,
                                                child: ListView.separated(
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              TextButton.icon(
                                                            onPressed: () {
                                                              homeCubit
                                                                  .get(context)
                                                                  .requestTODriver(
                                                                      model,
                                                                      context,
                                                                      index +
                                                                          1);
                                                              Nav(context,
                                                                  Home());
                                                            },
                                                            icon: Icon(
                                                              Icons.child_care,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            label: Text(
                                                              " ${index + 1} child",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  itemCount:
                                                      model.n_o_passengers -
                                                          model.cuurent,
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      height: 1,
                                                      width: double.infinity,
                                                      color: Colors.grey,
                                                    );
                                                  },
                                                ),
                                              )
                                            : Container(
                                                child: Text(
                                                  "${model.name} Car Is Full ",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.red),
                                                ),
                                              ));
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return x;
                                        });
                                    // homeCubit
                                    //     .get(context)
                                    //     .requestTODriver(model, context, 5);
                                    // Nav(context, Home());

                                    // print( u_model);
                                    // homeCubit.get(context).setDriverToRoad(model, context);
                                    // NavegatorPush(context, request(model: model,));
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [Colors.blue, Colors.green]),
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 150.0,
                                        maxHeight: 40.0,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Request Bus",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            letterSpacing: 2.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    homeCubit.get(context).canselRequest(
                                        m: model, context: context);
                                    Nav(context, Home());
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [Colors.blue, Colors.green]),
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 150.0,
                                        maxHeight: 40.0,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Cansel req ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            letterSpacing: 2.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                      // RatingBar.builder(
                      //   initialRating: 3,
                      //   minRating: 1,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: true,
                      //   itemCount: 5,
                      //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      //   itemBuilder: (context, _) => Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     print(rating);
                      //   },
                      // )
                    ],
                  );
                },
                condition: state is! setprofilloading,
                fallback: (BuildContext context) {
                  return Center(child: CircularProgressIndicator());
                },
              )),
            ));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  void openRatingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: RatingView(
              model: model,
            ),
          );
        });
  }
}
