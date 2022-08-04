import 'package:flutter/material.dart';
import 'package:todo_app/todo_items.dart';

class MySchedules extends StatelessWidget {
  const MySchedules(
      {Key? key, required this.todo, this.ableToChange, this.ableToDelete})
      : super(key: key);

  final Todo todo;
  final ableToChange;
  final ableToDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ableToChange(todo);
      },
      tileColor: Colors.grey,
      leading: IconButton(
        onPressed: () {
          ableToChange(todo);
        },
        icon:
            Icon(todo.isDone ? Icons.check_box : Icons.check_box_outline_blank),
      ),
      title: Text(
        todo.todoItem!,
        style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: IconButton(
        onPressed: () {
          ableToDelete(todo.id);
        },
        icon: Icon(
          Icons.delete,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}
