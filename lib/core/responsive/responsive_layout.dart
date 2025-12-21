import 'package:flutter/material.dart';
import 'breakpoints.dart';
import 'enums.dart';

/// A widget that builds different layouts based on the screen size.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Widget to display on mobile devices (< 600px)
  final Widget mobile;

  /// Widget to display on tablet devices (600px - 1024px)
  /// If null, [mobile] will be used.
  final Widget? tablet;

  /// Widget to display on desktop devices (> 1024px)
  /// If null, [tablet] or [mobile] will be used.
  final Widget? desktop;

  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= Breakpoints.tablet) {
      return DeviceType.desktop;
    } else if (width >= Breakpoints.mobile) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= Breakpoints.tablet) {
          return desktop ?? tablet ?? mobile;
        } else if (width >= Breakpoints.mobile) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
