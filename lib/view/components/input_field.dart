import 'package:cltxpj/features/app_theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData icon;
  final double? maxWidth;
  final void Function(String)? onChanged;

  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    required this.icon,
    this.maxWidth,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: TextInputType.number,
            style: TextStyle(color: TextColor.primaryColor),
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: TextColor.primaryColor.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                icon,
                color: IconColor.primaryColor.withValues(alpha: 0.8),
              ),
              filled: true,
              fillColor: IconColor.primaryColor.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppThemeColor.secondaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
