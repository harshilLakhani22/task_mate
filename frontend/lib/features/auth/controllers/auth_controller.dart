
import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/common/constants/text_strings.dart';
import 'package:flutter_with_node_1/common/methods/show_toast.dart';
import 'package:flutter_with_node_1/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_with_node_1/utils/api/api.dart';
import 'package:flutter_with_node_1/utils/api/rest_api.dart';
import 'package:flutter_with_node_1/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isPasswordHidden = true.obs;

  final RestAPI restAPI = Get.find<RestAPI>();

  /// LogIn
  void onLogIn() async {
    var response = await restAPI.postDataMethod(
      APIConstants.strLogInUrl,
      data: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );
    if (response == null || response?.isEmpty) {
      showToast(title: "Login Response is Null or Empty");
      return;
    }
    if (response['status'] == "success") {

      final localStorage = Get.find<MLocalStorage>();
      await localStorage.setToken(response['token']);
      var currLogInGetToken = localStorage.getToken();
      debugPrint("currLogInGetToken ==> $currLogInGetToken");
      await localStorage.keepUserSignIn();

      showToast(title: "Login Successful");
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(DashboardScreen());
      });
    } else {
      showToast(title: response.error.toString());
    }
  }

  /// SignUp
  Future<void> onSignUp() async{
    var response = await restAPI.postDataMethod(APIConstants.strSignUpUrl, data: {
      "email" : emailController.text,
      "password" : passwordController.text,
    });

    if (response == null || response?.isEmpty) {
      showToast(title: "SignUp Response is Null or Empty");
    }
    if(response['status'] == "success"){
      showToast(title: "Account Created Successfully");

      final localStorage = Get.find<MLocalStorage>();
      await localStorage.setToken(response['token']);
      await localStorage.keepUserSignIn();

      Get.to(DashboardScreen());
    }
  }

  /// Signup Validation
  bool onSignUpScreenValidation() {
    if (StringUtils.isNullOrEmpty(emailController.text)) {
      showToast(title: MTexts.strPlzEnterEmail);
      return false;
    }
    if (!EmailUtils.isEmail(emailController.text)) {
      showToast(title: MTexts.strPlzEnterValidEmail);
      return false;
    }
    if (StringUtils.isNullOrEmpty(passwordController.text)) {
      showToast(title: MTexts.strPlzEnterPassword);
      return false;
    }
    if (passwordController.text.toString() !=
        confirmPasswordController.text.toString()) {
      showToast(title: MTexts.strPasswordNotMatched);
      return false;
    }
    return true;
  }


  void clearUserData(){
    final localStorage = Get.find<MLocalStorage>();
    localStorage.removeUserData();
  }
}