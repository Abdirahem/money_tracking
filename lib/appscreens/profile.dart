// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixraac/appscreens/login.dart';

class Profile extends StatefulWidget {
  final String getName, getId;
  Profile({required this.getName, required this.getId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 300,
              color: Color(0xff27AAC4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: Icon(
                      FontAwesomeIcons.user,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(widget.getName.toString(),
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 10.h),
                  Text("Active Memeber",
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: Colors.white)),
                ],
              )),
          SizedBox(height: 10.h),
          ListTile(
            leading: Icon(FontAwesomeIcons.checkToSlot),
            title: Text("Transactions"),
          ),
          Divider(
            height: 12.h,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.tools),
            title: Text("Setting"),
          ),
          Divider(
            height: 12.h,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.key),
            title: Text("Forget Password"),
          ),
          Divider(
            height: 12.h,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignIn()));

                // Navigator.of(context).pop();
              });
            },
            child: ListTile(
              leading: Icon(FontAwesomeIcons.lock),
              title: Text("Log out"),
            ),
          ),
          Divider(
            height: 12.h,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
