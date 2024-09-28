import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/features/auth/screens/log_in_screen.dart';
import 'package:flutter_with_node_1/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_with_node_1/routes/app_page.dart';
import 'package:flutter_with_node_1/routes/app_routes.dart';
import 'package:flutter_with_node_1/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = Get.find<MLocalStorage>();
    return FutureBuilder(
      future: localStorage.init(), // Ensure storage is initialized
      builder: (context, snapshot) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: (localStorage.checkUserSignIn())
              ? DashboardScreen()
              : LogInScreen(),
          getPages: AppPage.list,
          initialRoute: AppRoutes.login,
        );
      },
    );
  }
}
