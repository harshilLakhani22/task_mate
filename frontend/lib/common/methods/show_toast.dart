
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/common/constants/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

/// Showing the toast with custom fields
void showToast({
  required String title,
  String? subTitle,
  SnackPosition? position,
}) {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }
  Get.snackbar(
    title,
    subTitle ?? '',
    messageText:
    StringUtils.isNullOrEmpty(subTitle) ? const SizedBox.shrink() : null,
    colorText: Colors.white,
    backgroundColor: MColors.darkerGrey,
    snackPosition: position ?? SnackPosition.BOTTOM,
    duration: const Duration(seconds: 1),
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
  );
}
