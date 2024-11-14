import 'package:flutter/material.dart';
import 'package:superfoods/app/helpers/services/navigation_service.dart';


class LeftNavFooter extends StatelessWidget {
  const LeftNavFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // Text style for the privacy policy link
    final TextStyle linkStyle =
        TextStyle(color: Theme.of(context).primaryColor);

    return Column(
      mainAxisSize: MainAxisSize.min, // Ensures the column takes minimum space
      children: [
        const Divider(),
        TextButton(
          onPressed: () {
            // Navigate to the Privacy Policy page
            NavigationService.toNamed('/privacy-policy');
          },
          child: Text('Privacy Policy', style: linkStyle),
        ),
        const SizedBox(height: 8),
        Text('© ${DateTime.now().year} Superfoods', style: linkStyle),
        const SizedBox(height: 8),
      ],
    );
  }
}
