import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/todo.dart';
import 'package:provider/provider.dart';
import 'database/todo_data.dart';

String? taskTitle;
class AddTask extends StatelessWidget {
  TodosDatabase notesDatabase=TodosDatabase();
  bool? isNew=true;
  AddTask({required this.isNew});

  @override

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('إضافة مهمة',
            style: TextStyle(
              fontFamily: 'Hacen',
              fontSize: 24.0,
            ),
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
            child: TextButton(
              onPressed: () async{
                isNew==true ?
                await newItem(context)
                    :await updateItem(context);
              },
              child: Text('حفظ',
              style: TextStyle(fontSize: 24.0,fontFamily: 'Hacen',color:Colors.white),textAlign: TextAlign.center,),
            ),
          ),
          color: Theme.of(context).primaryColor,
          elevation: 15.0,
        ),

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  onChanged: (value){ taskTitle=value; },
                  cursorColor: Theme.of(context).accentColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    labelText: 'اسم المهمة',
                    labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                    fillColor: Colors.transparent,
                    hintText: 'الاسم',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: 'Hacen',
                  ),
                ),
                SizedBox(height:25.0),
                Text('تاريخ المهمة',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Hacen',
                  fontSize: 16.0,
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${Provider.of<TodosDatabase>(context,listen: false).selectedDate2.day}/${Provider.of<TodosDatabase>(context,listen: false).selectedDate2.month}/${Provider.of<TodosDatabase>(context,listen: false).selectedDate2.year}',
                  textAlign: TextAlign.center,
                    style: TextStyle(
                    fontFamily: 'Hacen',
                    fontSize: 15.0,
                    color: Theme.of(context).accentColor,
                  ),),
                  IconButton(onPressed: (){
                    Provider.of<TodosDatabase>(context,listen: false).selectDate2(context);
                  }, icon: Icon(Icons.edit,
                  size: 20.0, color: Theme.of(context).primaryColor,),),
                ],
                  ),
                SizedBox(height:25.0),
                Text('وقت المهمة',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Hacen',
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${Provider.of<TodosDatabase>(context,listen: false).selectedTime2.format(context)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Hacen',
                        fontSize: 15.0,
                        color: Theme.of(context).accentColor,
                      ),),
                    IconButton(onPressed: (){
                      Provider.of<TodosDatabase>(context,listen: false).selectTime2(context);
                    }, icon: Icon(Icons.edit,
                      size: 20.0, color: Theme.of(context).primaryColor,),),
                  ],
                ),
              ],
            ),
            ),
          ),
        ),
    );
  }

  Future newItem(BuildContext context) async{
    var newTodo=Todo(title: taskTitle!,  dateTime:Provider.of<TodosDatabase>(context,listen: false).selectedDate2 , timeOfDay:Provider.of<TodosDatabase>(context,listen: false).selectedTime2);
    await Provider.of<TodosDatabase>(context,listen: false).create(newTodo);
    Navigator.pop(context);
  }

  Future updateItem(BuildContext context)async{
    var updatedTodo=Todo(title: taskTitle!,dateTime:Provider.of<TodosDatabase>(context,listen: false).selectedDate2 , timeOfDay:Provider.of<TodosDatabase>(context,listen: false).selectedTime2);
    final todo=updatedTodo.copy(
      title: taskTitle,dateTime: Provider.of<TodosDatabase>(context,listen: false).selectedDate2,timeOfDay: Provider.of<TodosDatabase>(context,listen: false).selectedTime2,
    );
    await Provider.of<TodosDatabase>(context,listen: false).update(todo);
    Navigator.pop(context);
  }
}
