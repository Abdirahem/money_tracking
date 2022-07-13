import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixraac/appscreens/login.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retypePassword = TextEditingController();

  bool? error, sending, success;
  String? msg;

  String phpurl = "http://192.168.1.20/tixraac/insert.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurl), body: {
      "email": email.text,
      "name": name.text,
      "password": password.text,
      "retypePassword": retypePassword.text,
    });

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array

      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        email.clear();
        name.clear();
        password.clear();
        retypePassword.clear();

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
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
              SizedBox(height: 15.h),
              Container(
                color: Colors.grey.shade200,
                width: 350.w,
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Fullname',
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
              Container(
                color: Colors.grey.shade200,
                width: 350.w,
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: retypePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Retype Password',
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.grey.shade500),
                  ),
                ),
              ),

              SizedBox(height: 15.h),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(25.h),
                  decoration: BoxDecoration(
                      color: Color(0xff27AAC4),
                      borderRadius: BorderRadius.circular(5)),
                  width: 350.w,
                  child: GestureDetector(
                    onTap: () {
                      if (name.text.isEmpty ||
                          email.text.isEmpty ||
                          password.text.isEmpty ||
                          retypePassword.text.isEmpty) {
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
                                'please all the fields',
                                style: TextStyle(color: Colors.white),
                              )),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        sendData();
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),

              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Already have an account?",
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
                      "Sign In",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff27AAC4),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
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
