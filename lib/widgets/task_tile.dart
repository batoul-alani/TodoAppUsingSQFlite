import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_appv2/addTaskScreen.dart';
import 'package:todo_appv2/database/todo_data.dart';

var ind=0;

class TaskTile extends StatelessWidget {
  final int? id;
  final String? taskTitle;
  final String? taskDate;
  final TimeOfDay? taskTime;

  TaskTile(this.id,this.taskTitle,this.taskDate,this.taskTime);
  @override
  Widget build(BuildContext context) {
    ind=this.id!;
    return Consumer<TodosDatabase>(
        builder:(context,notesDatabase,child) {
          return Card(
            color: Colors.white,
            elevation: 6.0,
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(taskTitle!, style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Hacen',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),),
                  SizedBox(height: 3.0,),
                  Text(DateFormat.jm().format(DateTime(taskTime!.hour,taskTime!.minute)), style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 13.0),),
                  SizedBox(height: 1.5,),
                  Text(DateFormat.yMEd().format(DateTime.parse(taskDate!)), style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 13.0,
                  ),),

                ],
              ),

              trailing:Wrap(
                   children: <Widget>[
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask(
                          isNew: false,
                      )
                        )
                      );
                },
                    icon: Icon(Icons.edit, color: Theme.of(context).accentColor,),
                ),
                    IconButton(onPressed: () async{
                      await Provider.of<TodosDatabase>(context,listen: false).readTodo(ind);
                      await Provider.of<TodosDatabase>(context,listen: false).delete(ind);
                      },
                      icon: Icon(Icons.delete, color: Theme.of(context).accentColor,),
                    ),
                  ],
                ),
            ),
          );
        }
    );
  }
}
