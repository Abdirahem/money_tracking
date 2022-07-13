// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tixraac/appscreens/login.dart';
import 'package:tixraac/appscreens/profile.dart';
import 'package:tixraac/appscreens/signup.dart';

class Home extends StatefulWidget {
  final String hoName, hoId;

  Home({required this.hoName, required this.hoId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  var names;
  @override
  void initState() {
    names = widget.hoName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerscaffoldkey,
      drawer: Drawer(
        child: Profile(
          getName: names.toString(),
          getId: widget.hoId.toString(),
        ),
      ),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff27AAC4),
          leading: IconButton(
              onPressed: () {
                if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                  //if drawer is open, then close the drawer
                  Navigator.pop(context);
                } else {
                  _drawerscaffoldkey.currentState!.openDrawer();
                  //if drawer is closed then open the drawer.
                }
              },
              icon: Icon(
                FontAwesomeIcons.bars,
              ))),
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
                    Text("Welcome",
                        style: GoogleFonts.roboto(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.h),
                    Text(widget.hoName.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                        )),
                    SizedBox(height: 20.h),
                    // Container(
                    //   height: 300,
                    //   child: Image.asset("imgs/bghome.png"),
                    // )
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
