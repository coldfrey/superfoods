import 'package:flutter/material.dart';
import 'package:superfoods/app/helpers/widgets/left_bar_footer.dart';
import 'package:superfoods/app/helpers/widgets/my_card.dart';
import 'package:superfoods/app/helpers/utils/my_shadow.dart';
import 'package:superfoods/app/helpers/utils/ui_mixins.dart';

class LeftBar extends StatefulWidget {
  final bool isCondensed;
  final List<Widget> content;

  const LeftBar({super.key, this.isCondensed = false, required this.content});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  bool isCondensed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return MyCard(
      paddingAll: 0,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 0.2),
      child: AnimatedContainer(
        color: leftBarTheme.background,
        width: isCondensed ? 70 : 304,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                child: Column(
                  children: [
                    ...widget.content,
                  ],
                ),
              ),
            ),
            if (!isCondensed) LeftNavFooter(),
          ],
        ),
      ),
    );
  }
}
