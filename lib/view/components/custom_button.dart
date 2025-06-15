import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:flutter/material.dart';

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
    final Widget button = FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        minimumSize: WidgetStateProperty.all(Size(minWidth ?? 0, height ?? 30)),
        maximumSize: WidgetStateProperty.all(
          Size(maxWidth ?? double.infinity, height ?? 30),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Text(text, style: context.bodySmallBold),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, height: height, child: button);
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          minWidth: minWidth ?? 0,
          minHeight: height ?? 0,
        ),
        child: SizedBox(width: maxWidth, height: height, child: button),
      ),
    );
  }
}
