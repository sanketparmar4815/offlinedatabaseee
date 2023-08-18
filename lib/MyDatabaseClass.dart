import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabseclass {
  Future<Database> GettingDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mydatabse.db');
// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table USERDATA (ID integer Primary Key Autoincrement,NAME text, EMAIL text , NUMBER text ,PASSWORD text)');
      await db.execute(
          'create table ContactBook (ID integer Primary Key Autoincrement,NAME text, NUMBER text,USERID integer)');
    });
    print("=====${path.toString()}");
    print("===DATABSE==${database}");

    return database;
  }

  Future<bool> InsertUserdata(String namee, String email, String numberrrr,
      String pass, Database dbbb) async {
    String usercheck = "select * from  USERDATA where EMAIL ='$email'";

    List<Map> usercheklist = await dbbb.rawQuery(usercheck);

    print("==U==${usercheklist}");

    if (usercheklist.length == 0) {
      String insertdat =
          "insert into USERDATA (NAME,EMAIL,NUMBER,PASSWORD)  values('$namee','$email','$numberrrr','$pass"
          "')";

      int aa = await dbbb.rawInsert(insertdat);
      print("==Inserted==$aa");
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map>> VierUserdtatttt(Database database) async {
    String ss = "Select * From USERDATA";
    List<Map> ll = await database.rawQuery(ss);
    print("USERDAYAYYYY======${ll}");

    return ll;
  }

  Future<void> deleteData(int userid, Database database) async {
    String delete = "Delete From USERDATA where ID = '$userid'";
    int dd = await database.rawDelete(delete);
  }

  Future<void> updatetdata(String uname, String uemail, String unumber,
      Database database, int userdddd) async {
    String uu =
        "Update USERDATA set NAME = '$uname', EMAIL = '$uemail' ,NUMBER = '$unumber' where ID =  '$userdddd'";

    int uuu = await database.rawUpdate(uu);
  }

  Future<List<Map>> loginuser(
      String email, String pass, Database database) async {
    String loginnn =
        "select * from USERDATA where EMAIL = '$email' and  PASSWORD = '$pass'";
    List<Map> ll = await database.rawQuery(loginnn);
    print("=====$ll");
    return ll;
  }

  Future<void> insertConatct(
      String name, String num, int userid, Database database) async {
    String insertconatc =
        "insert into ContactBook (NAME,NUMBER,USERID)  values('$name','$num','$userid')";

    int aa = await database.rawInsert(insertconatc);

    print("==$aa");
  }

  Future<List<Map>> viewConatct(int i, Database database) async {

    String selctconatc = "select * from ContactBook where USERID ='$i'";

  List<Map>  list  = await  database.rawQuery(selctconatc);
    return list;
  }
}
