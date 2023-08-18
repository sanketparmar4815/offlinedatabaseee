import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/MyDatabaseClass.dart';
import 'package:offlinedatabaseee/SigninPage.dart';
import 'package:offlinedatabaseee/SplashScreen.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? useremail;
  int? userid;

  List<Map> userconatctt = [];

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      useremail = SplashScreen.sp!.getString("EMAIL") ?? "dd";
      userid = SplashScreen.sp!.getInt("ID") ?? 0;
    });

    viewconatctData();
  }

  //  id  userid , Number , Name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                SplashScreen.sp!.setBool("loginstatus", false).then((value) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return SigninPage();
                    },
                  ));
                });
              },
              icon: Icon(Icons.logout))
        ],
        title: Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: userconatctt.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${userconatctt[index]['NAME']}"),
            subtitle: Text("${userconatctt[index]['NUMBER']}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "+",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          name.text = "";
          number.text = "";

          showDialog(
            context: context,
            builder: (context) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 150, horizontal: 10),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            controller: name,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            controller: number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            MyDatabseclass()
                                .insertConatct(name.text, number.text, userid!,
                                    SplashScreen.db!)
                                .then((value) {
                              Navigator.pop(context);
                              viewconatctData();
                            });
                          },
                          child: Text("Save"))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void viewconatctData() {
    MyDatabseclass().viewConatct(userid!, SplashScreen.db!).then((value) {
      setState(() {
        userconatctt = value;
      });
    });
  }
}
