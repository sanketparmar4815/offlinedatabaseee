import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/MyDatabaseClass.dart';

import 'SignUppage.dart';
import 'ViewuserData.dart';

class UpdatePage extends StatefulWidget {
  Map userdddd;

  UpdatePage(this.userdddd);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  bool nameerror = false;
  String nameerrorstring = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    name.text = widget.userdddd['NAME'];
    email.text = widget.userdddd['EMAIL'];
    number.text = widget.userdddd['NUMBER'];
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
                  hintText: "Enter Your number",
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
                  MyDatabseclass().updatetdata(
                      name.text, email.text, number.text, SignUppage.db!,widget.userdddd['ID']).then((value) {

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return ViewuserData();
                        },));


                  });
                }

                setState(() {});
              },
              child: Text("Update Data"))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
