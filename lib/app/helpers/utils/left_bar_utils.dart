import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:superfoods/app/helpers/widgets/custom_pop_menu.dart';
import '../services/auth_services.dart';
import '../services/navigation_service.dart';
import '../services/url_service.dart';
import '../widgets/my_container.dart';
import '../widgets/my_spacing.dart';
import '../widgets/my_text.dart';
import 'ui_mixins.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LabelWidget extends StatefulWidget {
  final String label;
  final List<String> atLeastRoles;

  const LabelWidget({
    super.key,
    required this.label,
    this.atLeastRoles = const [],
  });

  @override
  _LabelWidgetState createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> with UIMixin {
  bool isVisible = false;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = Get.find<AuthService>();
    checkVisibility();

    authService.userRoles.listen((roles) {
      checkVisibility();
    });
  }

  void checkVisibility() {
    if (widget.atLeastRoles.isEmpty) {
      isVisible = true;
    } else {
      isVisible = widget.atLeastRoles.any((role) => authService.hasRole(role));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(
              widget.label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          )
        : SizedBox.shrink();
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<String> atLeastRoles; // At least one of these roles
  final List<MenuItem> children;

  const MenuWidget({
    super.key,
    required this.iconData,
    required this.title,
    this.isCondensed = false,
    this.active = false,
    this.atLeastRoles = const [],
    this.children = const [],
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  bool isVisible = false;
  late Animation<double> _iconTurns;
  late AnimationController _animationController;
  late AuthService authService;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    authService = Get.find<AuthService>();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _animationController.drive(
      Tween<double>(begin: 0.0, end: 0.5)
          .chain(CurveTween(curve: Curves.easeIn)),
    );
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
    checkVisibility();

    authService.userRoles.listen((roles) {
      checkVisibility();
    });
  }

  void checkVisibility() {
    if (widget.atLeastRoles.isEmpty) {
      isVisible = true;
    } else {
      isVisible = widget.atLeastRoles.any((role) => authService.hasRole(role));
    }
    setState(() {});
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    // popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return SizedBox.shrink();

    // var route = Uri.base.fragment;
    // isActive = widget.children.any((element) => element.route == route);

    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (_) => hideFn = _,
        onChange: (_) {
          // popupShowing = _;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
              tilePadding: MySpacing.zero,
              initiallyExpanded: isActive,
              maintainState: true,
              onExpansionChanged: (_) {
                LeftbarObserver.notifyAll(widget.title);
                onChangeExpansion(_);
              },
              trailing: RotationTransition(
                turns: _iconTurns,
                child: Icon(
                  LucideIcons.chevronDown,
                  size: 18,
                  color: leftBarTheme.onBackground,
                ),
              ),
              iconColor: leftBarTheme.activeItemColor,
              childrenPadding: MySpacing.x(12),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.iconData,
                    size: 20,
                    color: isHover || isActive
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                  MySpacing.width(18),
                  Expanded(
                    child: MyText.labelLarge(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                  ),
                ],
              ),
              collapsedBackgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
              ),
              backgroundColor: Colors.transparent,
              children: widget.children,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    // LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          NavigationService.toNamed(widget.route!);

          // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          child: MyText.bodySmall(
            "${widget.isCondensed ? "" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover
                ? leftBarTheme.activeItemColor
                : leftBarTheme.onBackground,
            fontWeight: isActive || isHover ? 600 : 500,
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool enabled;
  final bool isCondensed;
  final List<String> atLeastRoles; // At least one of these roles
  final String? route;

  const NavigationItem({
    super.key,
    this.iconData,
    required this.title,
    this.enabled = true,
    this.isCondensed = false,
    this.atLeastRoles = const [],
    this.route,
  });

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;
  bool isVisible = false;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = Get.find<AuthService>();
    checkVisibility();
    authService.userRoles.listen((roles) {
      checkVisibility();
    });
  }

  void checkVisibility() {
    if (widget.atLeastRoles.isEmpty) {
      isVisible = true;
    } else {
      isVisible = widget.atLeastRoles.any((role) => authService.hasRole(role));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return SizedBox.shrink();

    bool isActive = UrlService.getCurrentUrl() == widget.route;

    Color rowColor = isActive || isHover
        ? leftBarTheme.activeItemBackground
        : Colors.transparent;

    Color textColor = isActive || isHover
        ? leftBarTheme.activeItemColor
        : leftBarTheme.onBackground;

    Color iconColor = (isHover || isActive)
        ? leftBarTheme.activeItemColor
        : leftBarTheme.onBackground;

    if (!widget.enabled) {
      textColor = leftBarTheme.disabledBackground;
      iconColor = leftBarTheme.disabledBackground;
    }

    return GestureDetector(
      onTap: () {
        if (widget.route != null && widget.enabled) {
          NavigationService.toNamed(widget.route!);
          // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          if (widget.enabled) {
            setState(() {
              isHover = true;
            });
          }
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: rowColor,
          padding: MySpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: textColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}