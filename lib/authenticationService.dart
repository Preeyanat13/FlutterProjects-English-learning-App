import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(String username, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      return userCredential.user != null; // ตรวจสอบว่าผู้ใช้ไม่เป็น null
    } catch (e) {
      return false; // ในกรณีที่เกิดข้อผิดพลาด
    }
  }

  Future<bool> register(String username, String password) async { // เพิ่มฟังก์ชันการลงทะเบียน
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      return userCredential.user != null; 
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {  // เพิ่มฟังก์ชันการออกจากระบบ
    // Implement logout logic here
    // clear user session 
    await _auth.signOut(); // เครียร์เซสชันผู้ใช้
    // Clear any stored data on Local Storage or Shared Preferences if needed
  }

  bool isAuthenticated() { // เช้กสถานะการล็อกอิน
    // Check if the user is authenticated
    // check value from local storage or shared preferences
    return true; // Placeholder implementation
  }
}
