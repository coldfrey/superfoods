import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:superfoods/app/helpers/extensions/string.dart';
import 'package:superfoods/app/helpers/theme/theme_customizer.dart';
import 'package:superfoods/app/views/layouts/top_level_left_bar_old.dart';


class AdminLeftBarContent extends StatelessWidget {
  const AdminLeftBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWidget(label: "admin".tr(), atLeastRoles: const ['admin']),
        MenuWidget(
          iconData: LucideIcons.users,
          isCondensed: ThemeCustomizer.instance.leftBarCondensed,
          atLeastRoles: const ['admin'],
          title: "Users",
          children: [
            MenuItem(
              title: "All",
              route: '/admin/users',
              isCondensed: ThemeCustomizer.instance.leftBarCondensed,
            ),
            MenuItem(
              title: "Create",
              route: '/admin/create-user',
              isCondensed: ThemeCustomizer.instance.leftBarCondensed,
            ),
          ],
        ),
      ],
    );
  }
}
