import 'package:flutter/material.dart';
import 'responsive.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget Function() mobile;
  final Widget Function()? tablet;
  final Widget Function() desktop;

  const ResponsiveScaffold({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: mobile(),
      tablet: tablet?.call() ?? mobile(),
      desktop: desktop(),
    );
  }
}
