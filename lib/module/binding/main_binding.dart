import 'package:get/get.dart';
import 'package:shuttleservice/controller/auth/forgot_pass_controller.dart';
import 'package:shuttleservice/controller/auth/login_screen_controller.dart';
import 'package:shuttleservice/controller/auth/splash_screen_controller.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => ForgotPassScreenController());
    // TODO: implement dependencies
  }
}