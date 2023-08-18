import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/Homepage.dart';
import 'package:offlinedatabaseee/MyDatabaseClass.dart';
import 'package:offlinedatabaseee/SignUppage.dart';

import 'SplashScreen.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Email"),
              controller: email,
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Password"),
              controller: password,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                MyDatabseclass()
                    .loginuser(email.text, password.text, SplashScreen.db!)
                    .then((value) {
                  if (value.length == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successfully")));

                    SplashScreen.sp!.setBool("loginstatus", true);

                    SplashScreen.sp!.setInt("ID", value[0]['ID']);
                    SplashScreen.sp!
                        .setString("EMAIL", value[0]['EMAIL'])
                        .then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return Homepage();
                        },
                      ));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User Not Found")));
                  }
                });
              },
              child: Text("Login")),
          Spacer(),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return SignUppage();
                  },
                ));
              },
              child: Text("Register?Create account"))
        ],
      ),
    );
  }
}
