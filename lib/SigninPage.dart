import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/MyDatabaseClass.dart';
import 'package:offlinedatabaseee/SignUppage.dart';
import 'package:sqflite/sqflite.dart';

class SigninPage extends StatefulWidget {
  static Database? db;

  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyDatabseclass().GettingDatabase().then((value) {
      setState(() {
        SigninPage.db = value;
      });

      print("=S==${SigninPage.db}");
    });
  }

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
                    .loginuser(email.text, password.text, SigninPage.db!)
                    .then((value) {
                  if (value.length == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successfully")));
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
