import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/controllers/todo_controller.dart';
import 'package:flutter_todo_getx/models/todo_model.dart';
import 'package:flutter_todo_getx/views/add_todo_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[500],
        centerTitle: true,
      ),
      body: Obx(() {
        return todoController.todoList.isEmpty
            ? _buildEmptyState() // ถ้าไม่มีรายการ จะแสดงข้อความแจ้งเตือน
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: todoController.todoList.length,
                  itemBuilder: (context, index) {
                    TodoModel todo = todoController.todoList[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: todo.isDone ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(todo.subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                        leading: Checkbox(
                          value: todo.isDone,
                          activeColor: Colors.green, // เปลี่ยนสี checkbox เป็นสีเขียว
                          onChanged: (bool? newValue) {
                            todoController.toggleTodo(index);
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _showDeleteDialog(context, index);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddTodoView());
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ถ้าไม่มีรายการ จะแสดงข้อความแจ้งเตือน
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.list_alt, size: 80, color: Colors.grey[400]),
          SizedBox(height: 10),
          Text(
            'ยังไม่มีรายการที่ต้องทำ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // แสดง Dialog ยืนยันการลบ
  void _showDeleteDialog(BuildContext context, int index) {
    Get.defaultDialog(
      title: "ลบรายการ",
      middleText: "คุณต้องการลบรายการนี้หรือไม่?",
      textConfirm: "ลบ",
      textCancel: "ยกเลิก",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        todoController.deleteTodo(index);
        Get.back();
      },
    );
  }
}
