import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tixraac/appscreens/login.dart';

void main() => runApp(ScreenUtilInit(
    designSize: Size(393, 781),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      );
    }));
