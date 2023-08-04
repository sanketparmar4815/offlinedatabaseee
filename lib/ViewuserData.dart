import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/SignUppage.dart';

import 'MyDatabaseClass.dart';

class ViewuserData extends StatefulWidget {
  const ViewuserData({Key? key}) : super(key: key);

  @override
  State<ViewuserData> createState() => _ViewuserDataState();
}

class _ViewuserDataState extends State<ViewuserData> {
  List<Map>? userdddd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ForUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userdddd!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text("${userdddd![index]['ID']}"),
            subtitle: Text("${userdddd![index]['EMAIL']}"),
            title: Text("${userdddd![index]['NAME']}"),
          );
        },
      ),
    );
  }

  void ForUserdata() {
    MyDatabseclass().VierUserdtatttt(SignUppage.db!).then((value) {
      print("===${value}");
      setState(() {
        userdddd = value;
      });
    });
  }
}
