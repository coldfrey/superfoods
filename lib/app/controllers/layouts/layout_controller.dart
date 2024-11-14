import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:superfoods/app/controllers/my_controller.dart';
import 'package:superfoods/app/helpers/services/auth_services.dart';
import 'package:superfoods/app/helpers/services/firebase_functions_service.dart';
import 'package:superfoods/app/helpers/theme/theme_customizer.dart';

class LayoutController extends MyController {
  final authService = Get.find<AuthService>();
  final functionsService = Get.find<FirebaseFunctionService>();
  final QuillEditorController quillHtmlEditor = QuillEditorController();

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.addTable,
    ToolBarStyle.blockQuote,
    ToolBarStyle.clean,
    ToolBarStyle.clearHistory,
    ToolBarStyle.codeBlock,
    ToolBarStyle.directionLtr,
    ToolBarStyle.directionRtl,
    ToolBarStyle.editTable,
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo,
    ToolBarStyle.image,
    ToolBarStyle.indentAdd,
    ToolBarStyle.indentMinus,
    ToolBarStyle.link,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.redo,
    ToolBarStyle.strike,
    ToolBarStyle.video,
  ];

  ThemeCustomizer themeCustomizer = ThemeCustomizer();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late final PageStorageKey<String> scrollKey = PageStorageKey<String>('LayoutScrollController');
  late final ScrollController scrollController = ScrollController();

  bool isSubmittingIssue = false;
  String feedbackDescription = '';
  int feedbackPriority = 0;

  static const enumFeedbackPriority = {
    0: 'Not Set',
    1: 'Urgent',
    2: 'High',
    3: 'Medium',
    4: 'Low',
  };

  void setFeedbackPriority(String value) {
    feedbackPriority = enumFeedbackPriority.entries
        .firstWhere((element) => element.value == value)
        .key;
  }


  @override
  void onReady() {
    super.onReady();
    ThemeCustomizer.addListener(onChangeTheme);
  }

  void onChangeTheme(ThemeCustomizer oldVal, ThemeCustomizer newVal) {
    themeCustomizer = newVal;
    update();

    if (newVal.rightBarOpen) {
      scaffoldKey.currentState?.openEndDrawer();
    } else {
      scaffoldKey.currentState?.closeEndDrawer();
    }
  }

  enableNotificationShade() {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  disableNotificationShade() {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  void logout() async {
    await authService.signOut();
    Get.offAllNamed(
      '/login',
    ); // Navigate to login screen and remove all previous routes
  }

  Future<bool> createIssue({
    required String route,
  }) async {
    try {
      if (isSubmittingIssue) {
        return false;
      }
      isSubmittingIssue = true;
      if (feedbackDescription.isEmpty) {
        Get.snackbar('Error', 'Description is required');
        isSubmittingIssue = false;
        return false;
      }

      await functionsService.callCreateFunction(
        'createLinearIssue',
        {
          'userEmail': authService.user!.email,
          'description': feedbackDescription,
          'priority': feedbackPriority,
          'route': route,
        },
      );
      Get.snackbar('Success', 'Issue created successfully');
      isSubmittingIssue = false;
      return true;
    } catch (e) {
      print('Error creating issue: $e');
      Get.snackbar('Error', 'Failed to create issue');
      isSubmittingIssue = false;
      return false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
    ThemeCustomizer.removeListener(onChangeTheme);
  }
}
