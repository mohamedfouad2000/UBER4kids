import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Shared/companents.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/cubit/home/homestates.dart';
import 'package:project/home/Home.dart';

class ContactUS extends StatelessWidget {
  // const ContactUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    var email = TextEditingController();
  var formkey = GlobalKey<FormState>();
    var msg = TextEditingController();

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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key:formkey ,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: [
                    Text("Contact Us",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 40)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("We Avaliable For You",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: true,
                      // onFieldSubmitted: (){},
                      onTap: () {},
                      controller: name,
                      onChanged: (i) {},
                      keyboardType: TextInputType.text,
                      obscureText: false,
                       validator: (value) {
        if (value != null && value.isEmpty) {
          return "plese enter Your name ";
        } else {
          return null;
        }
      },
                      // maxLines: 7,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Name",
                          border: InputBorder.none,
                          
                          // focusColor: Colors.amber
                          // prefixIcon: prefixIcon,
              
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: true,
                      // onFieldSubmitted: (){},
                      onTap: () {},
                      controller: email,
                      onChanged: (i) {},
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      // maxLines: 7,
                                     validator: (value) {
        if (value != null && value.isEmpty) {
          return "plese enter Your email ";
        } else {
          return null;
        }
      },
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Email",
                          border: InputBorder.none,
                          // focusColor: Colors.amber
                          // prefixIcon: prefixIcon,
              
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: true,
                      // onFieldSubmitted: (){},
                      onTap: () {},
                      
                      controller: msg,
                      onChanged: (i) {},
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      maxLines: 9,
                                        validator: (value) {
        if (value != null && value.isEmpty) {
          return "plese enter Your msg ";
        } else {
          return null;
        }
      },
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Message",
                          border: InputBorder.none,
                          // focusColor: Colors.amber
                          // prefixIcon: prefixIcon,
              
                          ),
                    ),
                  SizedBox(
                      height: 20,
                    ),
                    MaterialButton(onPressed: (){
                     if (formkey.currentState!.validate()) {
          homeCubit.get(context).complaints(email: email.text, msg: msg.text, name: name.text).then((value) {
            ShowToastFun(msg: "We will See Your complaints", Sort: toaststate.success);
                        Nav(context, Home());
                      });

                     }
                      
                    },
                    height: 60.0,
                    minWidth: double.infinity,
                    color: Colors.teal,
                    child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18),),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
