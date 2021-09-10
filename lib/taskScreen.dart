import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addTaskScreen.dart';
import 'widgets/task_list.dart';
import 'database/todo_data.dart';
import 'database/todo.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المهام',
          style: TextStyle(
            fontFamily: 'Hacen',
            fontSize: 24.0,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
            //Add Item
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddTask(
                isNew: true,
              )));
          },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
        ),
        elevation: 15.0,
      ),

      body: SafeArea(
        child: TaskList(),
      ),
    );
  }
}

