import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class GeneralController extends GetxController {
  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void storeUserRole(String userEmail) {
    if (userEmail == "admin@gmail.com") {
      prefs?.setString("user_role", "admin");
    } else {
      prefs?.setString("user_role", "user");
    }
  }

  String getUserRole() {
    return prefs?.getString("user_role") ?? '';
  }
}

// class GeneralController extends GetxController {
//   SharedPreferences? prefs;
//   RxString userRole = RxString('');
//   @override
//   void onInit() {
//     super.onInit();
//     initializeSharedPreferences();
//   }

//   Future<void> initializeSharedPreferences() async {
//     prefs = await SharedPreferences.getInstance();
//   }

//   void storeUserRole(String userEmail) {
//     if (userEmail == "admin@gmail.com") {
//       prefs?.setString("user_role", "admin");
//     } else {
//       prefs?.setString("user_role", "user");
//     }
//   }

//    getUserRole() {
//     userRole.value = prefs?.getString("user_role") ?? '';
//   }
// }

class SharedPreferencesService {
  static Future<void> saveUserProfile({
    required String name,
    required String phone,
    required String email,
    String? imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userPhone', phone);
    await prefs.setString('userEmail', email);
    if (imagePath != null) {
      await prefs.setString('userImage', imagePath);
    }
  }

  static Future<Map<String, String?>> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('userName'),
      'phone': prefs.getString('userPhone'),
      'email': prefs.getString('userEmail'),
      'image': prefs.getString('userImage'),
    };
  }
}
