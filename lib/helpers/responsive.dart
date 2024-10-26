import 'package:flutter/material.dart';

int largeScreenSize = 1366;
int mediumScreenSize = 768;
int smallScreenSize = 360;

class Responsive extends StatelessWidget {
  final Widget largeScreenWidget;
  final Widget mediumScreenWidget;
  final Widget smallScreenWidget;

  const Responsive({
    super.key,
    required this.largeScreenWidget,
    required this.mediumScreenWidget,
    required this.smallScreenWidget,
  });

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < mediumScreenSize;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < largeScreenSize;
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSize;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _width = constraints.maxWidth;
      if (_width >= largeScreenSize) {
        return largeScreenWidget;
      } else if (_width >= mediumScreenSize && _width < largeScreenSize) {
        return mediumScreenWidget;
      } else {
        return smallScreenWidget;
      }
    });
  }
}
