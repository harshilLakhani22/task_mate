import 'package:flutter_with_node_1/features/auth/controllers/auth_controller.dart';
import 'package:flutter_with_node_1/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_with_node_1/utils/api/rest_api.dart';
import 'package:flutter_with_node_1/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.put<MLocalStorage>(MLocalStorage()).init();

  Get.put<GetConnect>(GetConnect()); //initializing GetConnect

  Get.lazyPut<RestAPI>(() => RestAPI(), fenix: true);

  Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

  Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);


}
