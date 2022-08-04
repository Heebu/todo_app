class Todo {
  String? todoItem;
  String? id;
  late bool isDone;

  Todo({required this.id, required this.todoItem, this.isDone = false});

  static List<Todo> todoList() {
    return [];
  }
}
