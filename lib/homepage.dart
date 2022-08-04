import 'package:flutter/material.dart';
import 'package:todo_app/todo_items.dart';

import 'mySchedules.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _ableToChange(Todo todo) {
      setState(() {
        todo.isDone = !todo.isDone;
      });
    }

    void _ableToDelete(String id) {
      setState(() {
        todoList.removeWhere((item) => item.id == id);
      });
    }

    void _ableToAdd(String todo) {
      setState(() {
        todoList.add(Todo(
          id: (todoList.length + 1).toString(),
          todoItem: todo,
        ));
      });
      _todoController.clear();
    }

    void _runFilter(String enteredKeyword) {
      List<Todo> results = [];
      if (enteredKeyword.isEmpty) {
        results = todoList;
      } else {
        results = todoList
            .where((item) => item.todoItem!
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
      setState(() {
        _foundTodo = results;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Todo App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(radius: 25),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              onChanged: (value) {
                _runFilter(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(
              'My Schedules',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              margin: EdgeInsets.only(
                top: 20,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(children: [
                for (Todo todos in _foundTodo)
                  MySchedules(
                    todo: todos,
                    ableToChange: _ableToChange,
                    ableToDelete: _ableToDelete,
                  ),
              ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    right: 20,
                    left: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _todoController,
                        decoration: InputDecoration(hintText: 'Add a Task'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _ableToAdd(_todoController.text);
                        },
                        child: Text('Add'),
                      )
                    ],
                  ),
                );
              });
        },
        child: (Icon(Icons.add)),
      ),
    );
  }
}
