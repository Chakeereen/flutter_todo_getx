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
                            ),
                          ),
                          subtitle: Text(
                            todo.subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isDone,
                            onChanged: (bool? newValue) {
                              todoController.toggletodo(index);
                            },
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              todoController.deleteTodo(index);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
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

//   // ถ้าไม่มีรายการ จะแสดงข้อความแจ้งเตือน
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.list_alt, size: 80, color: Colors.grey[400]),
//           SizedBox(height: 10),
//           Text(
//             'ยังไม่มีรายการที่ต้องทำ',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }

//  // แสดง Dialog ยืนยันการลบ
//   void _showDeleteDialog(BuildContext context, int index) {
//         todoController.deleteTodo(index);
//         Get.back();
//     // Get.defaultDialog(
//     //   title: "ลบรายการ",
//     //   middleText: "คุณต้องการลบรายการนี้หรือไม่?",
//     //   textConfirm: "ลบ",
//     //   textCancel: "ยกเลิก",
//     //   confirmTextColor: Colors.white,
//     //   buttonColor: Colors.red,
//     //   onConfirm: () {
//     //     todoController.deleteTodo(index);
//     //     Get.back();
//     //   },
//     // );
//   }
}
