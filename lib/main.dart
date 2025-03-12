import 'package:flutter/material.dart';
import 'package:flutter_todo_getx/services/storage_service.dart';
import 'package:flutter_todo_getx/views/login_veiw.dart';
//import 'package:flutter_todo_getx/views/register_view.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await StorageService().init();
  
 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do GetX',
      home: LoginVeiw(),
    );
  }
}