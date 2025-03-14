import 'package:flutter_todo_getx/controllers/auth_controller.dart';
import 'package:flutter_todo_getx/models/todo_model.dart';
import 'package:flutter_todo_getx/services/storage_service.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{
  var todoList = <TodoModel>[].obs;
  StorageService storageService = StorageService();
  AuthController authController = Get.put(AuthController());
  RxBool isDeleting = false.obs;

  

  @override
  void onInit() {
    super.onInit();
    fetchTodoList();
  }
  Future<void> fetchTodoList() async {
    
    var todos = await storageService.read(
    'todoList',
    authController.user.value?.uid??'',
    );
    if (todos != null) {
      todoList.value = List<TodoModel>.from(
        todos.map((x) => TodoModel.fromJson(x)),
      );
    }
  }
 
  void addTodo(String title, String subtitle) {
    TodoModel todo = TodoModel(
      title, 
      subtitle, 
      false,
      uid: authController.user.value?.uid,
      );
      todoList.add(todo);
      storageService.write('todoList', todo.toJson());
  }
 
  void toggletodo(int index) {
    todoList[index].isDone = !todoList[index].isDone;
    todoList.refresh();
    storageService.update('todoList', todoList[index].docId ?? '',{
      'isDone': todoList[index].isDone,
    });
 
  }

  Future<void> updateTodo(TodoModel todo) async{
    todoList.firstWhere((todo) => todo.docId == todo.docId).title;
    todoList.firstWhere((todo) => todo.docId == todo.docId).subtitle;
    todoList.refresh();
    await storageService.update('todoList',todo.docId?? '',todo.toJson());
  }
 
  // void deleteTodo( int index) {
  //   var id = todoList.removeAt(index).docId.toString();
  //   storageService.delete('todoList', id);
    
  // }

  void deleteTodo( String docId) {
    todoList.removeWhere((todo) => todo.docId == docId);
    storageService.delete('todoList', docId);
    fetchTodoList();
    
    
  }

  void clearTodo() {
    todoList.clear();
    fetchTodoList();
  }
  

}