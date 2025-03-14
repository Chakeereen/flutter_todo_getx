import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/controllers/todo_controller.dart';
import 'package:flutter_todo_getx/models/todo_model.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddTodoView extends StatefulWidget {
  AddTodoView({super.key,this.todo});
  TodoModel? todo;

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TodoController todoController = Get.put(TodoController());

  final TextEditingController titleController = TextEditingController();

  final TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      subtitleController.text = widget.todo!.subtitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.todo == null ?  'เพิ่มรายการ' : 'แก้ไข', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("ชื่อรายการ"),
            _buildTextField(titleController, "ใส่ชื่อรายการ"),
            SizedBox(height: 20),
            _buildLabel("รายละเอียด"),
            _buildTextField(subtitleController, "ใส่รายละเอียด...", maxLines: 5),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity, // ปุ่มเต็มความกว้าง
              child: ElevatedButton(
                onPressed: () {
                  
                  if(widget.todo == null){
                      
                      todoController.addTodo(titleController.text, subtitleController.text);
                     
                      
                      Get.back();
                  
                      _showSnackbar();
                    
                  }
                  else {
                      if(titleController.text.isEmpty) return; 
                      widget.todo!.title = titleController.text;
                      widget.todo!.subtitle = subtitleController.text;
                      todoController.updateTodo(widget.todo!);
                      
                      
                      Get.back();
                  
                      _showSnackbar();
                    
                  }
                  
                },
                style: ElevatedButton.styleFrom( 
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('บันทึก', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _showSnackbar() {
    Get.snackbar(
      "สำเร็จ", 
      "บันทึกข้อมูลเรียบร้อย!",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.white),
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 1),
    );
  }
}
