import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/MyDatabaseClass.dart';
import 'package:offlinedatabaseee/SigninPage.dart';

import 'SplashScreen.dart';

class SignUppage extends StatefulWidget {
  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  bool nameerror = false;
  String nameerrorstring = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: name,
              onChanged: (value) {
                print("$value");
              },
              decoration: InputDecoration(
                  errorText: nameerror ? nameerrorstring : null,
                  hintText: "Enter Your Name",
                  labelText: "NAME",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  prefix: Icon(Icons.email),
                  hintText: "Enter Your Email",
                  labelText: "EMAIL",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: number,
              decoration: InputDecoration(
                  prefix: Icon(Icons.email),
                  hintText: "Enter Your Email",
                  labelText: "EMAIL",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                  prefix: Icon(Icons.email),
                  hintText: "Enter Your Email",
                  labelText: "EMAIL",
                  border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                RegExp nameRegExp = RegExp('[a-zA-Z]');

                nameerror = false;
                if (name.text.isEmpty) {
                  nameerrorstring = "plese fill name";
                  nameerror = true;
                } else if (!nameRegExp.hasMatch(name.text)) {
                  nameerrorstring = "Valid NAme";
                  nameerror = true;
                } else {
                  MyDatabseclass()
                      .InsertUserdata(name.text, email.text, number.text,
                          password.text, SplashScreen.db!)
                      .then((value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("User SuccessFully Register")));

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SigninPage();
                        },
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("User Already Exist!")));
                    }
                  });
                }

                setState(() {});
              },
              child: Text("Sign Up"))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
