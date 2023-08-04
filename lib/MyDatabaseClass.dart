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
        });
    print("=====${path.toString()}");
    print("===DATABSE==${database}");

    return database;
  }

  Future<void> InsertUserdata(String namee, String email, String numberrrr,
      String pass, Database dbbb) async {
    String insertdat =
        "insert into USERDATA (NAME,EMAIL,NUMBER,PASSWORD)  values('$namee','$email','$numberrrr','$pass"
        "')";

    int aa = await dbbb.rawInsert(insertdat);
    print("==Inserted==$aa");
  }

  Future<void> VierUserdtatttt(Database database) async {
    String ss = "Select * From USERDATA";
    List<Map> ll = await database.rawQuery(ss);
    print("USERDAYAYYYY======${ll}")
  }
}
