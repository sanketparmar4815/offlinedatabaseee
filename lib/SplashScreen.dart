import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:offlinedatabaseee/SigninPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'Homepage.dart';
import 'MyDatabaseClass.dart';

class SplashScreen extends StatefulWidget {
  static SharedPreferences? sp;
  static Database? db;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool Islogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyDatabseclass().GettingDatabase().then((value) {
      setState(() {
        SplashScreen.db = value;
      });

      print("=S==${SplashScreen.db}");
    });
    GettingShareperence();
  }

  GettingShareperence() async {
    SplashScreen.sp = await SharedPreferences.getInstance();

    setState(() {
      Islogin = SplashScreen.sp!.getBool("loginstatus") ?? false;
    });

    Future.delayed(Duration(seconds: 5)).then((value) {
      if (Islogin) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return SigninPage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        heightFactor: 200,
        widthFactor: 200,
        child: Lottie.asset("raw/loading.json"),
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
