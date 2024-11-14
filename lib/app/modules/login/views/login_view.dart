import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:superfoods/app/helpers/theme/app_theme.dart';
import 'package:superfoods/app/helpers/widgets/my_button.dart';
import 'package:superfoods/app/helpers/widgets/my_container.dart';
import 'package:superfoods/app/helpers/widgets/my_spacing.dart';
import 'package:superfoods/app/helpers/widgets/my_text.dart';
import 'package:superfoods/app/helpers/widgets/my_text_style.dart';
import 'package:superfoods/app/views/layouts/auth_layout_2.dart';
import 'package:superfoods/app/helpers/utils/ui_mixins.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> with UIMixin {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout2(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return MyContainer(
            child: Form(
              key: controller.basicValidator.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 35,
                      ),
                      MySpacing.width(16),
                      MyText.bodyMedium(
                        "Target",
                        fontSize: 24,
                        fontWeight: 600,
                      ),
                    ],
                  ),
                  Divider(
                    height: 40,
                  ),
                  Center(
                    child: Column(
                      children: [
                        MyText.bodyLarge(
                          "Sign In",
                          fontSize: 20,
                          fontWeight: 600,
                        ),
                        MySpacing.height(8),
                        MyText.bodyMedium(
                          "Stay updated on your professional world",
                          fontSize: 12,
                          fontWeight: 600,
                          xMuted: true,
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(20),
                  MyText.labelMedium(
                    "Email Address",
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator: controller.basicValidator.getValidation('email'),
                    controller:
                        controller.basicValidator.getController('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      prefixIcon: const Icon(
                        LucideIcons.mail,
                        size: 20,
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(20),
                  MyText.labelMedium(
                    "Password",
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    validator:
                        controller.basicValidator.getValidation('password'),
                    controller:
                        controller.basicValidator.getController('password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !controller.showPassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      prefixIcon: const Icon(
                        LucideIcons.lock,
                        size: 20,
                      ),
                      suffixIcon: InkWell(
                        onTap: controller.onChangeShowPassword,
                        child: Icon(
                          controller.showPassword
                              ? LucideIcons.eye
                              : LucideIcons.eyeOff,
                          size: 20,
                        ),
                      ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () =>
                            controller.onChangeCheckBox(!controller.isChecked),
                        child: Row(
                          children: [
                            Checkbox(
                              onChanged: controller.onChangeCheckBox,
                              value: controller.isChecked,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: getCompactDensity,
                            ),
                            MySpacing.width(16),
                            MyText.bodyMedium(
                              "Remember Me",
                            ),
                          ],
                        ),
                      ),
                      MyButton.text(
                        onPressed: controller.goToForgotPassword,
                        elevation: 0,
                        padding: MySpacing.xy(8, 0),
                        splashColor: contentTheme.secondary.withOpacity(0.1),
                        child: MyText.labelSmall(
                          'Forgot Password?',
                          color: contentTheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(16),
                  Center(
                    child: MyButton.rounded(
                      onPressed: controller.onLogin,
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: contentTheme.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.loading
                              ? SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    color: theme.colorScheme.onPrimary,
                                    strokeWidth: 1.2,
                                  ),
                                )
                              : Container(),
                          if (controller.loading) MySpacing.width(16),
                          MyText.bodySmall(
                            'Login',
                            color: contentTheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.errorMessage.value != "")
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[50], // Light red background
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                        border: Border.all(color: Colors.red), // Red border
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 20,
                          ), // Error icon
                          SizedBox(
                            width: 8,
                          ), // Space between icon and text
                          Expanded(
                            // Allows text to wrap if it's too long
                            child: Text(
                              controller.errorMessage.value,
                              style: TextStyle(
                                color: Colors.red, // Red text color
                                fontSize: 14, // Increased font size
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyContainer.bordered(
                        onTap: () {},
                        paddingAll: 8,
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.github,
                              size: 16,
                              color: Color(0xff4078c0),
                            ),
                            MySpacing.width(12),
                            MyText.bodyMedium(
                              "GitHub",
                              fontWeight: 600,
                            ),
                          ],
                        ),
                      ),
                      MyContainer.bordered(
                        onTap: () {},
                        paddingAll: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              LucideIcons.twitter,
                              size: 16,
                              color: Color(0xff00acee),
                            ),
                            MySpacing.width(12),
                            MyText.bodyMedium(
                              "Twitter",
                              fontWeight: 600,
                            ),
                          ],
                        ),
                      ),
                      MyContainer.bordered(
                        onTap: () {},
                        paddingAll: 8,
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.facebook,
                              size: 16,
                              color: Color(0xff3b5998),
                            ),
                            MySpacing.width(12),
                            MyText.bodyMedium(
                              "Facebook",
                              fontWeight: 600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(20),
                  Center(
                    child: MyButton.text(
                      onPressed: controller.gotoRegister,
                      elevation: 0,
                      padding: MySpacing.x(16),
                      splashColor: contentTheme.secondary.withOpacity(0.1),
                      child: MyText.labelMedium(
                        "Don't have a account ?",
                        color: contentTheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}