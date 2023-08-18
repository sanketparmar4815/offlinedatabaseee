import 'package:flutter/material.dart';
import 'package:offlinedatabaseee/UpdatePage.dart';

import 'MyDatabaseClass.dart';
import 'SplashScreen.dart';

class ViewuserData extends StatefulWidget {
  const ViewuserData({Key? key}) : super(key: key);

  @override
  State<ViewuserData> createState() => _ViewuserDataState();
}

class _ViewuserDataState extends State<ViewuserData> {
  List<Map> userdddd = [];
  List<Map> searchlist = [];

  bool IsSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ForUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IsSearch
          ? AppBar(
              backgroundColor: Colors.yellow,
              title: TextField(
                onChanged: (value) {
                  print("===$value");

                  if (value.isNotEmpty) {
                    searchlist = [];
                    for (int i = 0; i < userdddd.length; i++) {
                      String name = userdddd[i]['NAME'];
                      print("==$name");

                      if (name.toUpperCase().contains(value.toUpperCase())) {
                        print("SEARCH NAME==$name");

                        searchlist.add(userdddd[i]);
                      }
                    }
                  } else {
                    searchlist = userdddd;
                  }

                  setState(() {});
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            IsSearch = false;
                            searchlist = userdddd;
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder()),
              ),
            )
          : AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        IsSearch = true;
                      });
                    },
                    icon: Icon(Icons.search))
              ],
              title: Text("Contact Book"),
            ),
      body: ListView.builder(
        itemCount: IsSearch ? searchlist.length : userdddd.length,
        itemBuilder: (context, index) {
          Map map = IsSearch ? searchlist[index] : userdddd[index];

          return ListTile(
            trailing: PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return UpdatePage(userdddd![index]);
                    },
                  ));
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(value: 1, child: Text("update")),
                  PopupMenuItem(
                      value: 2,
                      onTap: () {
                        int userid = map['ID'];

                        MyDatabseclass()
                            .deleteData(userid, SplashScreen.db!)
                            .then((value) {
                          ForUserdata();
                        });
                      },
                      child: Text("Delete"))
                ];
              },
            ),
            leading: Text("${map['ID']}"),
            subtitle: Text("${map['EMAIL']}"),
            title: Text("${map['NAME']}"),
          );
        },
      ),
    );
  }

  void ForUserdata() {
    MyDatabseclass().VierUserdtatttt(SplashScreen.db!).then((value) {
      print("===${value}");
      setState(() {
        userdddd = value;
        searchlist = value;
      });
    });
  }
}
