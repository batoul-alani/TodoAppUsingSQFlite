import 'package:flutter/material.dart';
import 'todo_data.dart';

class Todo {
  final int? id;
  final String title;
  final DateTime dateTime;
  final TimeOfDay timeOfDay;

  const Todo(
      { this.id, required this.title, required this.dateTime, required this.timeOfDay,});

  Todo copy(
      {int? id, String? title, DateTime? dateTime, TimeOfDay? timeOfDay,}) =>
      Todo(id: id ?? this.id,
          title: title ?? this.title,
          dateTime: dateTime ?? this.dateTime,
          timeOfDay: timeOfDay ?? this.timeOfDay);

  Map<String, Object?> toMap() {
    return {
      TDate.i: id,
      TDate.t: title,
      TDate.dt: dateTime.toIso8601String(),
      TDate.tod: '${timeOfDay.hour}:${timeOfDay.minute}',
    };
  }

  static Todo fromMap(Map<String, Object?>json) {
    return Todo(
        id: json[TDate.i] as int?,
        title: json[TDate.t] as String,
        dateTime: DateTime.parse(json[TDate.dt] as String),
        timeOfDay: TimeOfDay(
            hour: int.parse(json[TDate.tod].toString().split(":")[0]),
            minute: int.parse(json[TDate.tod].toString().split(":")[1])));
  }
}

