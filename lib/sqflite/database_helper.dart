import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../JSON/users.dart';

class DatabaseHelper {
  final databaseName = "auth.db";

  //Tables

  //Don't put a comma at the end of a column in sqlite

  String user = '''
   CREATE TABLE users (
   usrId INTEGER PRIMARY KEY ,
   fullName TEXT,
   email TEXT UNIQUE,
   usrName TEXT UNIQUE,
   usrPassword TEXT
  
   );
   ''';
  String userproduct = '''
   CREATE TABLE userproduct (
   usrId  INTEGER primary key ,
   usr_Name text ,
   amount INTEGER,
   usrproduct TEXT,
   productprice Integer,
   productpicture TEXT,
   FOREIGN KEY (usr_Name) references users (usrName)
   );
   ''';

  //Our connection is ready
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(userproduct);
    });
  }

  //Function methods

  //Authentication
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where usrName = '${usr.usrName}' and usrPassword= '${usr.password}'  ");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> createUser(Users usr) async {
    final Database db = await initDB();

    return db.insert("users", {
      "fullName": usr.toMap()["fullName"],
      "email": usr.toMap()["email"],
      "usrName": usr.toMap()["usrName"],
      "usrPassword": usr.toMap()["usrPassword"],
    });
  }

  Future<int> createcart(Users usr) async {
    final Database db = await initDB();

    return db.insert("userproduct", {
      "usr_Name": usr.toMap()["usrName"],
      "usrproduct": usr.toMap()["usrproduct"],
      "productprice": usr.toMap()["productprice"],
      "productpicture": usr.toMap()["productpicture"],
      "amount": usr.toMap()["amount"],
    });
  }

  //Get current User details
  Future<Users?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);

    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<void> updatecart(String? usr_pic, Users usr) async {
    final Database db = await initDB();
    await db.update(
      'userproduct',
      {
        "usr_Name": usr.toMap()["usrName"],
        "usrproduct": usr.toMap()["usrproduct"],
        "productprice": usr.toMap()["productprice"],
        "productpicture": usr.toMap()["productpicture"],
        "amount": usr.toMap()["amount"],
      },
      where: 'productpicture = ?',
      whereArgs: [usr_pic],
    );
  }

  Future<List?> checkuser() async {
    final Database db = await initDB();
    var res = await db.rawQuery("select * from users");
    print(res);
    return res.toList();
  }

  Future<List?> getcart(String? usr_Name) async {
    final Database db = await initDB();
    var res = await db
        .rawQuery("select * from userproduct where usr_Name='$usr_Name'");
    print(res.toList());
    return res.toList();
  }

  Future<List?> checkcartamount(String? usr_pic) async {
    final Database db = await initDB();
    var res = await db
        .rawQuery("select * from userproduct where productpicture='$usr_pic'");
    print(res.toList());
    return res.toList();
  }

  Future<bool?> checkcart(String? usr_Name) async {
    final Database db = await initDB();
    var res = await db
        .rawQuery("select * from userproduct where usr_Name='$usr_Name'");
    if (res.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool?> checkcartexist(String? usr_pic) async {
    final Database db = await initDB();
    var res = await db
        .rawQuery("select * from userproduct where productpicture='$usr_pic'");
    if (res.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<int> delete(String picture) async {
    Database db =  await initDB();
    return await db.delete("userproduct",
        where: 'productpicture = ?', whereArgs: [picture]);
  }

  Future<int> deleteall(String? usr_Name) async {
    Database db = await await initDB();
    return await db
        .delete("userproduct", where: 'usr_Name = ?', whereArgs: [usr_Name]);
  }
}
