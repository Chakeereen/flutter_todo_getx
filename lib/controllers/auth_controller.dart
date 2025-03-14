import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_getx/views/home_view.dart';
import 'package:flutter_todo_getx/views/login_veiw.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  var user = Rxn<User>();
  

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> register(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password,
      );
      Get.snackbar('สำเร็จ', 'สมัครสมาชิกสำเร็จ');
    } catch(e) {
      Get.snackbar('ผิดพลาด', e.toString());
    }
  }

  Future<void> login (String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
        );
        Get.snackbar('สำเร็จ', 'ล็อกอินสำเร็จ');
        Get.off(HomeView());
        
    } catch(e){
      Get.snackbar("ผิดพลาด", e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar("สำเร็จ", "ออกจากระบบสำเร็จ");
      Get.off(LoginVeiw());
    } catch (e) {
      Get.snackbar('ผิดพลาด', e.toString());
    }
  }
}  

