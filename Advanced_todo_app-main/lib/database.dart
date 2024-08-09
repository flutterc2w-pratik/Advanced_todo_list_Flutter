import 'package:flutter_advanedtodo/todo.dart';
import'package:sqflite/sqflite.dart';
import'package:path/path.dart' as path;

dynamic database;

//create database and table 
Future<void> databaseFun()async{
  database= await openDatabase(
     path.join(await getDatabasesPath(),"advancedtodo.db"),
     version: 1,
     onCreate:(db, version)async{
     await  db.execute(
         '''CREATE TABLE todoInfo(
          taskId INTEGER PRIMARY KEY AUTOINCREMENT,
          head TEXT,
          desc TEXT,
           date TEXT,
           )'''
       );
       
     },
  );
 getData();

}

//insert tasks 

Future<void> importData(TodoModel obj)async{
   final localDB=await database;
   await localDB.insert(
    'todoInfo',
     obj.toMap(),
    conflictAlgorithm:ConflictAlgorithm.replace,
   );
}

//gettasks
Future<List<TodoModel>> getData()async{
  final localDB=await database;
 List<Map<String,dynamic>> listData=await localDB.query('todoInfo');
  return List.generate(listData.length,(i){
    return TodoModel(
      taskId: listData[i]['taskId'],
      head: listData[i]['head'] , 
      desc: listData[i]['desc'] , 
      date: listData[i]['date'],
      );
  });

}

//delete Task
Future<void> deletetask(TodoModel todoobj)async{
  final localDB=await database;
  await localDB.delete(
    'TodoInfo',
    where:'taskId=?',
    whereArgs:[todoobj.taskId],
  );
}

//update Task
Future<void> updateTask(TodoModel todoobj)async{
  final localDB=await database;
  await localDB.update(
    'TodoInfo',
     todoobj.toMap(),
     where:'taskId=?',
     whereArgs:[todoobj.taskId],
  );
 // todoobj.isChecked=!todoobj.isChecked;
}