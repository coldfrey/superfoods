import 'package:flutter/material.dart';
import 'package:superfoods/app/data/models/notification.dart';

import '../../helpers/theme/admin_theme.dart';
import '../../helpers/theme/app_theme.dart';
import '../../helpers/widgets/my_button.dart';
import '../../helpers/widgets/my_container.dart';
import '../../helpers/widgets/my_dashed_divider.dart';
import '../../helpers/widgets/my_spacing.dart';
import '../../helpers/widgets/my_text.dart';

Widget buildTopBarNotifications(List<SimpleNotification> notifications) {
  final contentTheme = AdminTheme.theme.contentTheme;

  Widget buildNotification(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelLarge(title),
        MySpacing.height(4),
        MyText.bodySmall(description),
        MySpacing.height(12),
      ],
    );
  }

  return MyContainer.bordered(
    paddingAll: 0,
    width: 250,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: MySpacing.xy(16, 12),
          child: MyText.titleMedium("Notification", fontWeight: 600),
        ),
        MyDashedDivider(
          height: 1,
          color: theme.dividerColor,
          dashSpace: 4,
          dashWidth: 6,
        ),
        Padding(
          padding: MySpacing.xy(16, 12),
          child: notifications.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: notifications
                      .map(
                        (notification) => buildNotification(
                          notification.title,
                          notification.description,
                        ),
                      )
                      .toList(),
                )
              : Center(
                  child: MyText.bodySmall(
                    "No Notifications",
                    textAlign: TextAlign.center,
                    color: theme.hintColor,
                  ),
                ),
        ),
        MyDashedDivider(
          height: 1,
          color: theme.dividerColor,
          dashSpace: 4,
          dashWidth: 6,
        ),
        Padding(
          padding: MySpacing.xy(16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyButton.text(
                onPressed: notifications.isNotEmpty ? () {} : null,
                splashColor: contentTheme.primary.withAlpha(28),
                child: MyText.labelSmall(
                  "View All",
                  color: notifications.isNotEmpty
                      ? contentTheme.primary
                      : theme.hintColor,
                ),
              ),
              MyButton.text(
                onPressed: notifications.isNotEmpty ? () {} : null,
                splashColor: contentTheme.danger.withAlpha(28),
                child: MyText.labelSmall(
                  "Clear",
                  color: notifications.isNotEmpty
                      ? contentTheme.danger
                      : theme.hintColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
