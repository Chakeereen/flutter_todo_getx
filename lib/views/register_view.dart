import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/controllers/auth_controller.dart';
import 'package:flutter_todo_getx/widgets/app_text_field.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  RegisterView({super.key});
  //const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),
        backgroundColor: Colors.green[500],
        centerTitle: true,
        ),
      
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(label: 'Email', controller: emailController),
            AppTextField(label: 'Password', controller: passwordController,hideText: true,),
            AppTextField(label: 'Confirm Password', controller: confirmPasswordController,hideText: true,),
            ElevatedButton(
              onPressed: () {
                if (!GetUtils.isEmail(emailController.text)) {
                  Get.snackbar('Error', 'Invalid email address');
                  return;
                }
                if(passwordController.text.length <6) {
                  Get.snackbar('Error', 'Password must be at least 6 characters');
                  return;
                }
                if(passwordController.text != confirmPasswordController.text) {
                  Get.snackbar('Error', 'Password does not match');
                  return;
                }
                authController.register(emailController.text, passwordController.text);

              },
              
               child: Text('Register')),
               
          ],
          
        ),
      )
    );
  }
}