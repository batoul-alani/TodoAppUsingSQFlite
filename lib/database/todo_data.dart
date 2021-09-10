import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableTodo = 'todos';

class TDate{
  static final List<String> values=[i, t,dt,tod];
  static final String i = '_id';
  static final String t = 't';
  static final String dt = 'dt';
  static final String tod = 'tod';
}

class TodosDatabase extends ChangeNotifier{
  DateTime selectedDate2=DateTime.now();
  TimeOfDay selectedTime2=TimeOfDay.now();

  selectTime2(BuildContext context)async{
    final TimeOfDay? selectedT=await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );
    if(selectedT !=null && selectedT!=selectedTime2){
      selectedTime2=selectedT;
    }
    print(selectedTime2);
    notifyListeners();
    return TimeOfDay(hour: selectedTime2.hour, minute: selectedTime2.minute);
  }
  selectDate2(BuildContext context)async{
    final DateTime? selected=await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );

    if(selected !=null && selected!=selectedDate2) {
      selectedDate2 = selected;
    }
    notifyListeners();
    return selectedDate2;
  }

  List<Todo> _todos=[];
  List<Todo> get todos => _todos;

  TodosDatabase();
  static final TodosDatabase instance=TodosDatabase._init();
  static Database? _database;
  TodosDatabase._init();

  Future<Database> get database async{
    if (_database !=null) return _database!;
    _database=await _initDB('to.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath)async{
    final dbPath=await getDatabasesPath();
    final path=join(dbPath,filePath);
    return await openDatabase(path, version: 1,onCreate: _createDB);
  }

  Future _createDB(Database dbb,int version) async {
    final idType ='INTEGER PRIMARY KEY AUTOINCREMENT';
    final tType='TEXT NOT NULL';
    final dtType='DateTime FOR TIME';
    final todType='TEXT NOT NULL';
    await dbb.execute(''
        'CREATE TABLE $tableTodo(${TDate.i} $idType,${TDate.t} $tType,${TDate.dt} $dtType,${TDate.tod} $todType)');
  }

  Future<Todo> create(Todo todo)async{
    final db=await instance.database;
    await db.insert(tableTodo, todo.toMap());
    notifyListeners();
    print('Saved Sucessfully');
    return todo;
  }

  Future<Todo> readTodo(int id)async{
    final dbb=await instance.database;
    final maps=await dbb.query(tableTodo,columns: TDate.values,where: '${TDate.i}=?',whereArgs: [id]);
    notifyListeners();
    if(maps.isNotEmpty){
      return Todo.fromMap(maps.first);
    }else{
      throw Exception('ID $id not found');
    }
  }

  Future<void> readAllTodos()async{
    final dbb=await instance.database;
    final orderBy='${TDate.dt} ASC';
    final result=await dbb.query(tableTodo,orderBy: orderBy);
    _todos=result.map((json) => Todo.fromMap(json)).toList();
    notifyListeners();
  }

  Future<int> update(Todo todo)async{
    final dbb=await instance.database;
    notifyListeners();
    return await dbb.update(tableTodo, todo.toMap(),where: '${TDate.i}=?',whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async{
    final dbb=await instance.database;
    notifyListeners();
    return await dbb.delete(tableTodo,where: '${TDate.i}=?',whereArgs: [id]);
  }

  Future close() async{
    final db=await instance.database;
    db.close();
  }
}
