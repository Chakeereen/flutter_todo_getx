import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_getx/controllers/auth_controller.dart';
import 'package:flutter_todo_getx/views/register_view.dart';
import 'package:flutter_todo_getx/widgets/app_text_field.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class LoginVeiw extends StatelessWidget {
   LoginVeiw({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green[500],
        
        ),
      body:Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(label: 'Email', controller: emailController),
            AppTextField(label: 'Password', controller: passwordController,hideText: true),
            ElevatedButton(onPressed: () {
              if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar('Error', 'Invalid email address');
                  return;
                }
                if(passwordController.text.length <6) {
                  Get.snackbar('Error', 'Password must be at least 6 characters');
                  return;
                }
              authController.login(emailController.text, passwordController.text);
            }, child: Text('Login')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () {
              Get.to(RegisterView());
            }, child: Text('Register')),
            
          ],
          
        ),
      )
    );
  }
}