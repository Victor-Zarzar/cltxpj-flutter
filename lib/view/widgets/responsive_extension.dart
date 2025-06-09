import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

extension ResponsiveTextStyle on BuildContext {
  UiProvider get ui => Provider.of<UiProvider>(this, listen: true);

  // Heading Styles

  TextStyle get h1 => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 13),
    fontWeight: FontWeight.w900,
    color: TextColor.primaryColor,
  );

  TextStyle get h2 => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 11),
    fontWeight: FontWeight.w500,
    color: TextColor.primaryColor,
  );

  //Body Styles

  TextStyle get bodyLarge => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 18),
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get bodyMedium => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 16),
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get bodySmall => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 12),
    color: TextColor.primaryColor,
  );

  TextStyle get bodySmallDark => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 12),
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get bodySmallDarkBold => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 12),
    fontWeight: FontWeight.bold,
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get bodySmallBold => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 12),
    fontWeight: FontWeight.bold,
    color: TextColor.primaryColor,
  );

  TextStyle get textSmall => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 9),
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get textSmallBold => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 9),
    fontWeight: FontWeight.bold,
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get bodyIconButton => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 9),
    fontWeight: FontWeight.w600,
    color: ui.isDark ? TextColor.primaryColor : TextColor.fourthColor,
  );

  TextStyle get bodyMediumFont => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 13),
    fontWeight: FontWeight.w600,
    color: TextColor.primaryColor,
  );

  TextStyle get footerMediumFont => GoogleFonts.roboto(
    fontSize: ResponsiveText.getSize(this, 11),
    fontWeight: FontWeight.w600,
    color: TextColor.primaryColor,
  );
}
