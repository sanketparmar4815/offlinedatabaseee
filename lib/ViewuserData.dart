import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/SignUppage.dart';

import 'MyDatabaseClass.dart';

class ViewuserData extends StatefulWidget {
  const ViewuserData({Key? key}) : super(key: key);

  @override
  State<ViewuserData> createState() => _ViewuserDataState();
}

class _ViewuserDataState extends State<ViewuserData> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ForUserdata();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void ForUserdata() {

    MyDatabseclass().VierUserdtatttt(SignUppage.db!);



  }


}
