// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tixraac/appscreens/profile.dart';
import 'package:tixraac/appscreens/signup.dart';
import 'package:tixraac/transactions/transaction.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var error_message;
  String phpurl = "http://192.168.1.20/tixraac/login.php";
  String? username;
  String? idString;
  int? userId;

  ReadData() async {
    var response = await http.post(Uri.parse(phpurl), body: {
      "email": email.text,
      "password": password.text,
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        if (jsonData['uid'] == null) {
          final snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
                alignment: Alignment.center,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.red.shade800,
                ),
                child: const Text(
                  'Incorrect email or password',
                  style: TextStyle(color: Colors.white),
                )),
          );
          email.clear();
          password.clear();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          username = jsonData["fname"];
          userId = int.parse(jsonData["uid"]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Transaction(
                        user_id: userId.toString(),
                        uname: username.toString(),
                      )));
        }
        email.clear();
        password.clear();
      });
      if (jsonData["error"]) {
        print("Error has accoured");
      } else {
        if (jsonData["success"]) {
          // print("success");
        } else {
          print("there an error ");
        }
      }
    } else {
      print("database error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // logo and text notes

              SizedBox(height: 60.h),
              Center(
                child: Container(
                  width: 300.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.chartLine,
                        size: 40,
                        color: Color(0xff27AAC4),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Idhaqaale",
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Lasoco halka aad lacagtaada \nka hesho iyo halka ay kaaga baxdo.",
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      color: Colors.grey.shade200,
                      width: 350.w,
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Email@example.com',
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 18.sp, color: Colors.grey.shade500),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      color: Colors.grey.shade200,
                      width: 350.w,
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: password,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.roboto(
                              fontSize: 18.sp, color: Colors.grey.shade500),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(
                      onTap: () {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                                alignment: Alignment.center,
                                height: 50,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green.shade800,
                                ),
                                child: const Text(
                                  'Please enter email or password',
                                  style: TextStyle(color: Colors.white),
                                )),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          setState(() {
                            ReadData();
                          });
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(25.h),
                          decoration: BoxDecoration(
                              color: Color(0xff27AAC4),
                              borderRadius: BorderRadius.circular(5)),
                          width: 350.w,
                          child: Text(
                            "Login",
                            style: GoogleFonts.roboto(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Create a new account?",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(_createRoute());
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff27AAC4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
