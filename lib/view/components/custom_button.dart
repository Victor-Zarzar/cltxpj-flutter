import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double? maxWidth;
  final double? minWidth;
  final double? height;
  final bool fullWidth;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.maxWidth,
    this.minWidth,
    this.height = 30,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = GFButton(
      onPressed: onPressed,
      color: color,
      fullWidthButton: fullWidth,
      size: GFSize.LARGE,
      shape: GFButtonShape.standard,
      child: Text(text),
    );

    if (fullWidth) {
      return SizedBox(height: height, width: double.infinity, child: button);
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          minWidth: minWidth ?? 0,
          minHeight: height ?? 0,
        ),
        child: SizedBox(
          width: maxWidth, // Esse é o segredo para web
          height: height,
          child: button,
        ),
      ),
    );
  }
}
