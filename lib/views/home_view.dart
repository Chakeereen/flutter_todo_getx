import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/controllers/auth_controller.dart';
import 'package:flutter_todo_getx/controllers/todo_controller.dart';
import 'package:flutter_todo_getx/models/todo_model.dart';
import 'package:flutter_todo_getx/views/add_todo_view.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TodoController todoController = Get.put(TodoController());

  final AuthController authController = AuthController();

  @override
   void initState() {
    super.initState();
    todoController.fetchTodoList(); // Ensure onInit is called every time HomeView is used
  }

  Widget build(BuildContext context) {
    todoController.fetchTodoList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[500],
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            todoController.clearTodo();
            authController.logout();
          }, 
          icon: Icon(Icons.logout))
        ],
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todoController.todoList.length,
                itemBuilder: (context, index) {
                  TodoModel todo = todoController.todoList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Card(
                      elevation: 4, // ให้เงาสำหรับการตกแต่ง
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // มุมโค้งมน
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ), // ขอบกรอบ
                          color: Colors.white, // พื้นหลังสีขาว
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: 
                                todo.isDone ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          subtitle: Text(
                            todo.subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                               decoration: 
                                todo.isDone ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (bool? newValue) {
                              todoController.toggletodo(index);
                            },
                          ),
                          trailing: IconButton(
                            onPressed: () async{
                              print(todo.toJson());
                             todoController.deleteTodo(todo.docId ?? '');
                              
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                          onTap: () {
                            Get.to(AddTodoView(todo: todo));
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddTodoView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
