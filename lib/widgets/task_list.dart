import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_appv2/database/todo.dart';
import 'package:todo_appv2/widgets/task_tile.dart';
import 'package:todo_appv2/database/todo_data.dart';

class TaskList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Provider.of<TodosDatabase>(context).readAllTodos();
    return Consumer<TodosDatabase>(
      builder:(context,notesDatabase,child){
        return ListView.builder (
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(15.0),
          itemCount: notesDatabase.todos.length,
          itemBuilder: (context,index) {
            Todo todo=notesDatabase.todos[index];
            return TaskTile( todo.id,todo.title,  todo.dateTime.toString(),  todo.timeOfDay);
            },
          );
        },
    );
  }
}
