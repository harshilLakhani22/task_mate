import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/common/constants/colors.dart';
import 'package:flutter_with_node_1/common/constants/sizes.dart';
import 'package:flutter_with_node_1/common/constants/text_strings.dart';
import 'package:flutter_with_node_1/common/widgets/common_elevated_button.dart';
import 'package:flutter_with_node_1/common/widgets/common_text_field.dart';
import 'package:flutter_with_node_1/features/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

import 'log_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonTextField(
              controller: authController.emailController,
              keyboardType: TextInputType.emailAddress,
              hint: "Email",
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            /// Password
            CommonTextField(
              controller: authController.passwordController,
              hint: "Password",
              isObscureText: true,
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            /// Confirm Password
            Obx(
              () => CommonTextField(
                controller: authController.confirmPasswordController,
                hint: "Confirm Password",
                isObscureText: authController.isPasswordHidden.value,
                icon: authController.isPasswordHidden.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                fillColor: (Theme.of(context).brightness == Brightness.dark
                    ? MColors.black
                    : MColors.grey),
                onTap: () {
                  authController.isPasswordHidden.value =
                      !authController.isPasswordHidden.value;
                },
              ),
            ),

            const SizedBox(height: MSizes.spaceBtwSections),
            /// Already have Account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already Have an Account? ",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAll(LogInScreen());
                  },
                  child: const Text(
                    "LogIn",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: MSizes.spaceBtwItems),

            /// SignUp Button
            CommonElevatedButton(
              onPressed: () {
                if (authController.onSignUpScreenValidation()) {
                  authController.onSignUp();
                }
              },
              title: MTexts.strSigunUp,
            ),
            const SizedBox(height: MSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
