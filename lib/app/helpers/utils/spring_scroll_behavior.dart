/*
# Spring Scroll Behavior

The `SpringScrollBehavior` class extends the `ScrollBehavior` class to customize the scrolling behavior within a `Scrollable` widget.

## Functionality:

- Overrides the `buildViewportChrome` method to return the original child without any additional chrome decoration.
- Overrides the `getScrollPhysics` method to provide custom scrolling physics using `BouncingScrollPhysics` with a specified deceleration rate.

## Methods:

- `buildViewportChrome`: Overrides the method to return the original child without any additional chrome decoration.
- `getScrollPhysics`: Overrides the method to provide custom scrolling physics using `BouncingScrollPhysics`.

*/ 

import 'package:flutter/material.dart';

class SpringScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics(
        parent: const AlwaysScrollableScrollPhysics(),
        decelerationRate: ScrollDecelerationRate.values[1]);
  }
}
