import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/common/constants/sizes.dart';
import 'package:flutter_with_node_1/features/auth/controllers/auth_controller.dart';
import 'package:flutter_with_node_1/features/auth/screens/log_in_screen.dart';
import 'package:flutter_with_node_1/features/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter_with_node_1/features/dashboard/widgets/display_text_input_dialog.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final DashboardController dashboardController =
      Get.find<DashboardController>()..getToDoListPost();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
        actions: [
          IconButton(
              onPressed: () {
                authController.clearUserData();
                Get.to(LogInScreen());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Obx(() {
          if (dashboardController.isFetchingTodos.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dashboardController.todoModelList.isEmpty) {
            return const Center(child: Text("No Todos Found"));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2,
                      color: Colors.red,
                    );
                  },
                  itemCount: dashboardController.todoModelList.length,
                  itemBuilder: (context, index) {
                    var todo = dashboardController.todoModelList[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(todo.description),
                        leading: const Icon(Icons.today_outlined),
                        onLongPress: () {
                          dashboardController.todoUpdateTitleController.text =
                              todo.title;
                          dashboardController
                              .todoUpdateDescriptionController.text =
                              todo.description;
                          displayTextInputDialog(
                            context,
                            isForEdit: true,
                            todoTitleController:
                                dashboardController.todoUpdateTitleController,
                            todoDescriptionController: dashboardController
                                .todoUpdateDescriptionController,
                            onSubmit: () {
                              dashboardController.updateTodo(
                                todoId: todo.id,
                                title: dashboardController
                                    .todoUpdateTitleController.text,
                                description: dashboardController
                                    .todoUpdateDescriptionController.text,
                              );
                              dashboardController.clearController();
                              Get.back();
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayTextInputDialog(
            context,
            todoTitleController: dashboardController.todoTitleController,
            todoDescriptionController:
                dashboardController.todoDescriptionController,
            onSubmit: () {
              dashboardController.addTodo();
              dashboardController.clearController();
              Get.back();
              dashboardController.getToDoListPost();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
