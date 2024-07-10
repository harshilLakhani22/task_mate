import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/common/constants/sizes.dart';
import 'package:flutter_with_node_1/features/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

final DashboardController dashboardController = Get.find<DashboardController>();

Future<void> displayTextInputDialog(
  BuildContext context, {
  required TextEditingController todoTitleController,
  required TextEditingController todoDescriptionController,
  required Function() onSubmit,
  bool isForEdit = false,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: isForEdit ? const Text('Edit To-Do') : const Text('Add To-Do'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: todoTitleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),
            TextField(
              controller: todoDescriptionController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),
            ElevatedButton(
              onPressed: onSubmit,
              child: isForEdit ? const Text("Edit") : const Text("Add"),
            )
          ],
        ),
      );
    },
  );
}
