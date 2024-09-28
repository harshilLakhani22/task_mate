import 'package:flutter_with_node_1/features/auth/screens/log_in_screen.dart';
import 'package:flutter_with_node_1/features/auth/screens/sign_up_screen.dart';
import 'package:flutter_with_node_1/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_with_node_1/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPage {
  static List<GetPage> list = [
    GetPage(name: AppRoutes.login, page: LogInScreen.new),
    GetPage(name: AppRoutes.signUp, page: SignUpScreen.new),
    GetPage(name: AppRoutes.dashboard, page: DashboardScreen.new),
  ];
}
