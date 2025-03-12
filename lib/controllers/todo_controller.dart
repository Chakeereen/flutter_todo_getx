import 'package:flutter_todo_getx/models/todo_model.dart';
import 'package:flutter_todo_getx/services/storage_service.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{
  var todoList = <TodoModel>[].obs;
  StorageService storageService = StorageService();

  @override
  void onInit() {
    super.onInit();
    fetchTodoList();
  }
  void fetchTodoList() {
    var todos = storageService.read('todoList');
    if (todos != null) {
      todoList.value = List<TodoModel>.from(
        todos.map((x) => TodoModel.fromJson(x)),
      );
    }
  }
 
  void addTodo(String title, String subtitle) {
    todoList.add(TodoModel(title, subtitle, false));
    storageService.write('todoList', todoList.toJson());
  }
 
  void toggletodo(int index) {
    todoList[index].isDone = !todoList[index].isDone;
    todoList.refresh();
    storageService.write('todoList', todoList.toJson());
  }
 
  void deleteTodo(int index) {
    todoList.removeAt(index);
    storageService.write('todoList', todoList.toJson());
  }
}