import 'package:crudapp/model/modalclass.dart';
import 'package:crudapp/view/getinfopage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

dynamic database;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //to create database or open if already created
  database = openDatabase(
    join(await getDatabasesPath(),"pi.db"),
    onCreate: (db, version) {
      //to create table
      db.execute(
        '''
            CREATE TABLE userinfo(
              panNo TEXT PRIMARY KEY,
              name TEXT,
              email TEXT,
              phoneNo TEXT,
              add1 TEXT,
              add2 TEXT,
              postCode INT,
              city TEXT,
              state TEXT
            )
        '''
      );
    },
    version: 1
  );
  
  runApp(const MainApp());
}

//to insert data into table
insertData(String table,UserInfo user)async{
  Database db = await database;
  await db.insert(table, user.retMap(),conflictAlgorithm: ConflictAlgorithm.replace);
}

//to delete data into table
deleteData(String table,UserInfo user)async{
  Database db = await database;
  await db.delete(table,where: "panNo= ?",whereArgs: [user.pan]);
}

//to update data into table
updateData(String table,UserInfo user)async{
  Database db = await database;
  await db.update(table, user.retMap(),where: "panNo= ?",whereArgs: [user.pan],conflictAlgorithm: ConflictAlgorithm.replace);
}

//to read data from table
getData(String table)async{
  Database db = await database;

  List usrlst = await db.query(table);

  return usrlst;
}

//main app 
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GetInfoPage(isUpdate: false,),
      debugShowCheckedModeBanner: false,
    );
  }
}
