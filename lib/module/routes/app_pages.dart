import 'package:get/route_manager.dart';
import 'package:shuttleservice/module/binding/main_binding.dart';
import 'package:shuttleservice/module/routes/app_routes.dart';
import 'package:shuttleservice/view/screen/auth/forgot_password_screen.dart';
import 'package:shuttleservice/view/screen/auth/login_screen.dart';
import 'package:shuttleservice/view/screen/auth/splash_screen.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: MainBinding(),
      children: [
        GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
        GetPage(name: Routes.FORGOTPASS, page: () => ForgotPasswordScreen()),
      ],
    ),
  ];
}
