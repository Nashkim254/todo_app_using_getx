import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
