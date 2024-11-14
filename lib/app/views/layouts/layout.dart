import 'package:superfoods/app/controllers/layouts/layout_controller.dart';
import 'package:superfoods/app/controllers/layouts/top_bar_controller.dart';
import 'package:superfoods/app/helpers/widgets/custom_pop_menu.dart';
import 'package:superfoods/app/views/layouts/right_bar.dart';
import 'package:superfoods/app/helpers/widgets/my_flex.dart';
import 'package:superfoods/app/helpers/widgets/my_flex_item.dart';
import 'package:superfoods/app/views/navigation/left_bar_content/top_level_navigation_content.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superfoods/app/helpers/theme/admin_theme.dart';
import 'package:superfoods/app/helpers/theme/app_style.dart';
import 'package:superfoods/app/helpers/theme/app_theme.dart';
import 'package:superfoods/app/helpers/theme/theme_customizer.dart';
import 'package:superfoods/app/helpers/widgets/my_button.dart';
import 'package:superfoods/app/helpers/widgets/my_container.dart';
import 'package:superfoods/app/helpers/widgets/my_responsiv.dart';
import 'package:superfoods/app/helpers/widgets/my_spacing.dart';
import 'package:superfoods/app/helpers/widgets/my_text.dart';
import 'package:superfoods/app/helpers/widgets/responsive.dart';
import 'package:superfoods/app/views/layouts/left_bar.dart';
import 'package:superfoods/app/views/layouts/top_bar.dart';
import 'package:superfoods/app/views/notifications/top_bar_notifications.dart';
import '../navigation/left_bar_content/admin_left_bar_content.dart';

class Layout extends StatelessWidget {
  final Widget? child;

  final LayoutController controller = LayoutController();
  late final TopBarController topBarController = Get.put(TopBarController());
  final topBarTheme = AdminTheme.theme.topBarTheme;
  final contentTheme = AdminTheme.theme.contentTheme;

  final bool contentIsScrollable;

  Layout({
    super.key,
    this.child,
    this.contentIsScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return MyResponsive(
      builder: (BuildContext context, _, screenMT) {
        return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile
                ? mobileScreen(context)
                : largeScreen(context);
          },
        );
      },
    );
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Site Logo and Name
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.offAllNamed('/'); // Navigate to Home page
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      // Site Name
                      const Text(
                        'Superfoods',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              ThemeCustomizer.setTheme(
                ThemeCustomizer.instance.theme == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
            child: Icon(
              ThemeCustomizer.instance.theme == ThemeMode.dark
                  ? FeatherIcons.sun
                  : FeatherIcons.moon,
              size: 18,
              color: topBarTheme.onBackground,
            ),
          ),
          MySpacing.width(4),
          CustomPopupMenu(
            backdrop: true,
            onChange: (_) {},
            offsetX: -180,
            menu: Padding(
              padding: MySpacing.xy(8, 8),
              child: Center(
                child: Icon(
                  FeatherIcons.bell,
                  size: 18,
                ),
              ),
            ),
            menuBuilder: (_) => buildTopBarNotifications([]),
          ),
          MySpacing.width(4),
          CustomPopupMenu(
            backdrop: true,
            onChange: (_) {},
            offsetX: -90,
            offsetY: 4,
            menu: Padding(
              padding: MySpacing.xy(8, 8),
              child: MyContainer.rounded(
                paddingAll: 0,
                child: Image.asset(
                  'assets/avatar.png',
                  height: 28,
                  width: 28,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            menuBuilder: (_) => buildAccountMenu(),
          ),
          MySpacing.width(4),
        ],
      ),
      drawer: LeftBar(
        isCondensed: ThemeCustomizer.instance.leftBarCondensed,
        content: const [AdminLeftBarContent()],
      ),
      body: SingleChildScrollView(
        key: controller.scrollKey,
        child: child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _handleFeedback(context),
        backgroundColor: AdminTheme.theme.contentTheme.primary,
        child: Icon(FeatherIcons.messageSquare),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget largeScreen(BuildContext context) {
    String currentRoute = Get.currentRoute;
    List<Widget> leftBarContent = [];
    // print('currentRoute: $currentRoute');

    if (currentRoute == '/all-projects') {
      leftBarContent.add(
        TopLevelNavigationContent(
          isCondensed: ThemeCustomizer.instance.leftBarCondensed,
        ),
      ); // Default content
    }

    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: RightBar(),
      body: Column(
        children: [
          // TopBar at the top
          TopBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LeftBar under the TopBar
                LeftBar(
                  isCondensed: ThemeCustomizer.instance.leftBarCondensed,
                  content: leftBarContent,
                ),
                // Main content area
                Expanded(
                  child: contentIsScrollable
                      ? SingleChildScrollView(
                          key: controller.scrollKey,
                          child: child,
                        )
                      : child ?? Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: theme.colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.user,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "My Account",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => {},
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: theme.colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.settings,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Settings",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => controller.logout(),
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.logOut,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleFeedback(BuildContext context) {
    // You can implement this method to open a feedback form or dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Feedback"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("page: ${Get.currentRoute}"),
              SizedBox(
                height: 400,
                width: 400,
                child: Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: MyFlex(
                    children: [
                      MyFlexItem(
                        sizes: "lg-8",
                        child: Column(
                          children: [
                            // ToolBar(
                            //   padding: const EdgeInsets.all(8),
                            //   iconSize: 20,
                            //   controller: controller.quillHtmlEditor,
                            //   toolBarConfig: controller.customToolBarList,
                            // ),
                            // QuillHtmlEditor(
                            //   text:
                            //       "Hello This is a quill html editor example 😊",
                            //   hintText: 'Hint text goes here',
                            //   controller: controller.quillHtmlEditor,
                            //   isEnabled: true,
                            //   minHeight: 300,
                            //   hintTextAlign: TextAlign.start,
                            //   textStyle: MyTextStyle.bodySmall(),
                            //   padding: const EdgeInsets.only(left: 10, top: 5),
                            //   hintTextPadding: EdgeInsets.zero,
                            //   backgroundColor: contentTheme.background,
                            //   onFocusChanged: (hasFocus) =>
                            //       debugPrint('has focus $hasFocus'),
                            //   onTextChanged: (text) =>
                            //       debugPrint('widget text change $text'),
                            //   onEditorCreated: () =>
                            //       debugPrint('Editor has been loaded'),
                            //   onEditorResized: (height) =>
                            //       debugPrint('Editor resized $height'),
                            //   onSelectionChanged: (sel) => debugPrint(
                            //     '${sel.index},${sel.length}',
                            //   ),
                            // ),
                            Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                  ),
                                  minLines: 4,
                                  maxLines: null,
                                  onChanged: (value) {
                                    controller.feedbackDescription = value;
                                  },
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Priority',
                                  ),
                                  value: 'Not Set',
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Not Set',
                                      child: Text('Default'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Urgent',
                                      child: Text('Urgent'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'High',
                                      child: Text('High'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Medium',
                                      child: Text('Medium'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Low',
                                      child: Text('Low'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controller.setFeedbackPriority(value!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            controller.isSubmittingIssue
                ? CircularProgressIndicator()
                : Container(),
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                Navigator.of(context).pop();
                await controller.createIssue(
                  route: Get.currentRoute,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
