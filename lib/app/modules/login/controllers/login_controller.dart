import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superfoods/app/helpers/services/auth_services.dart';
import 'package:superfoods/app/helpers/services/navigation_service.dart';
import 'package:superfoods/app/helpers/widgets/my_form_validator.dart';
import 'package:superfoods/app/helpers/widgets/my_validators.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false, isChecked = false;
  RxString errorMessage = "".obs;

  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(text: ""),
    );

    basicValidator.addField(
      'password',
      required: true,
      label: "Password",
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(text: ""),
    );
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      String email = basicValidator.getController('email')?.text ?? "";
      String password = basicValidator.getController('password')?.text ?? "";
      var errors = await authService.loginUser(email, password);
      if (errors != null) {
        print(errors);
        errorMessage.value = "Email or password is incorrect.";
        update();
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        // basicValidator.clearErrors();
      } else {
        String nextUrl =
            Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                    .queryParameters['next'] ??
                "/all-projects";
        NavigationService.toNamed(
          nextUrl,
        );
      }
      loading = false;
      update();
    }
  }

  void goToForgotPassword() {
    NavigationService.toNamed('/auth/forgot-password');
  }

  void gotoRegister() {
    Get.offAndToNamed('/auth/register1');
  }

  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
