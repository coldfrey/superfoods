import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:superfoods/app/helpers/extensions/string.dart';
import 'package:superfoods/app/views/layouts/top_level_left_bar_old.dart';

class ProfileLeftBarContent extends StatelessWidget {
  final bool isCondensed;

  const ProfileLeftBarContent({super.key, required this.isCondensed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWidget(label: "me".tr()),
        NavigationItem(
          iconData: LucideIcons.user,
          title: "profile".tr(),
          route: '/my-profile',
          isCondensed: isCondensed,
        ),
      ],
    );
  }
}
