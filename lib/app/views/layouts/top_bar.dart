import 'package:superfoods/app/controllers/layouts/top_bar_controller.dart';
import 'package:superfoods/app/helpers/services/navigation_service.dart';
import 'package:superfoods/app/helpers/storage/firebase_storage.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:superfoods/app/helpers/localizations/language.dart';
import 'package:superfoods/app/helpers/theme/app_notifier.dart';
import 'package:superfoods/app/helpers/theme/app_style.dart';
import 'package:superfoods/app/helpers/theme/app_theme.dart';
import 'package:superfoods/app/helpers/theme/theme_customizer.dart';
import 'package:superfoods/app/helpers/utils/my_shadow.dart';
import 'package:superfoods/app/helpers/utils/ui_mixins.dart';
import 'package:superfoods/app/helpers/widgets/custom_pop_menu.dart';
import 'package:superfoods/app/helpers/widgets/my_button.dart';
import 'package:superfoods/app/helpers/widgets/my_card.dart';
import 'package:superfoods/app/helpers/widgets/my_container.dart';
import 'package:superfoods/app/helpers/widgets/my_spacing.dart';
import 'package:superfoods/app/helpers/widgets/my_text.dart';
import 'package:superfoods/app/helpers/widgets/my_text_style.dart';
import 'package:superfoods/app/views/notifications/top_bar_notifications.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key, // this.onMenuIconTap,
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with SingleTickerProviderStateMixin, UIMixin {
  late TopBarController topBarController;
  Function? languageHideFn;

  bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  @override
  void initState() {
    super.initState();
    topBarController = Get.put(TopBarController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: topBarController,
      builder: (context) {
        String routeDebugString = Get.currentRoute;
        if (routeDebugString.contains('site/')) {
          routeDebugString = "site/" + routeDebugString.split('site/').last;
        }

        return MyCard(
          shadow:
              MyShadow(position: MyShadowPosition.bottomRight, elevation: 0.5),
          height: 60,
          borderRadiusAll: 0,
          padding: MySpacing.x(22),
          color: topBarTheme.background.withAlpha(246),
          child: Row(
            children: [
              Row(
                children: [
                  SizedBox(
                    // height: 70,
                    width: 350,
                    child: InkWell(
                      onTap: () {
                        NavigationService.toNamed('/');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: theme.colorScheme.onSurface,
                            highlightColor: theme.colorScheme.onSurface,
                            onTap: () {
                              ThemeCustomizer.toggleLeftBarCondensed();
                            },
                            child: Icon(
                              LucideIcons.menu,
                              color: topBarTheme.onBackground,
                            ),
                          ),
                          // Image.asset(
                          //   Images.logoIcon,
                          //   // height: widget.isCondensed ? 24 : 32,
                          //   height: 40,
                          //   // color: contentTheme.primary,
                          // ),
                          // if (!widget.isCondensed)
                          Flexible(
                            fit: FlexFit.loose,
                            child: MySpacing.width(8),
                          ),
                          // if (!widget.isCondensed)
                          Flexible(
                            fit: FlexFit.loose,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Get.offAllNamed('/'); // Navigate to Home page
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/logo.png',
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    // Site Name
                                    const Text(
                                      'Superfoods',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    MySpacing.width(12),
                    // CustomPopupMenu(
                    //   backdrop: true,
                    //   hideFn: (_) => languageHideFn = _,
                    //   onChange: (_) {},
                    //   offsetX: -36,
                    //   menu: Padding(
                    //     padding: MySpacing.xy(8, 8),
                    //     child: Center(
                    //       child: ClipRRect(
                    //         clipBehavior: Clip.antiAliasWithSaveLayer,
                    //         borderRadius: BorderRadius.circular(2),
                    //         child: Image.asset(
                    //           "assets/lang/${ThemeCustomizer.instance.currentLanguage.locale.languageCode}.jpg",
                    //           width: 24,
                    //           height: 18,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   menuBuilder: (_) => buildLanguageSelector(),
                    // ),
                    MySpacing.width(6),
                    CustomPopupMenu(
                      backdrop: true,
                      onChange: (_) {},
                      offsetX: -120,
                      menu: Padding(
                        padding: MySpacing.xy(8, 8),
                        child: const Center(
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
                      offsetX: -60,
                      offsetY: 8,
                      menu: Padding(
                        padding: MySpacing.xy(8, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyContainer.rounded(
                              paddingAll: 0,
                              child: Obx(
                                () => ImageFromStorage(
                                  imagePath: topBarController.photoURL.value,
                                ),
                              ),
                            ),
                            MySpacing.width(8),
                            Obx(
                              () => MyText.labelLarge(
                                topBarController.displayName.value
                                    .split(' ')
                                    .first,
                              ),
                            ),
                          ],
                        ),
                      ),
                      menuBuilder: (_) => buildAccountMenu(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLanguageSelector() {
    return MyContainer.bordered(
      padding: MySpacing.xy(8, 8),
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Language.languages
            .map(
              (language) => MyButton.text(
                padding: MySpacing.xy(8, 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashColor: contentTheme.onBackground.withAlpha(20),
                onPressed: () async {
                  // languageHideFn?.call();
                  // await Provider.of<AppNotifier>(context, listen: false)
                  //     .changeLanguage(language, notify: true);
                  // ThemeCustomizer.notify();
                  // setState(() {});
                },
                child: Row(
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        "assets/lang/${language.locale.languageCode}.jpg",
                        width: 18,
                        height: 14,
                        fit: BoxFit.cover,
                      ),
                    ),
                    MySpacing.width(8),
                    MyText.labelMedium(language.languageName),
                  ],
                ),
              ),
            )
            .toList(),
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
                  onPressed: () {
                    NavigationService.toNamed('/my-profile');
                    setState(() {});
                  },
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
                        "My Profile",
                        fontWeight: 600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                topBarController.logout();
              },
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

  @override
  void dispose() {
    Get.delete<TopBarController>();
    super.dispose();
  }
}
