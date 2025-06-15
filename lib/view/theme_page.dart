import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cltxpj/features/theme_provider.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<UiProvider>(context);

    return Scaffold(
      backgroundColor:
          notifier.isDark
              ? BackGroundColor.fourthColor
              : BackGroundColor.primaryColor,
      appBar: AppBar(
        title: Text("select_theme".tr(), style: context.h1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: IconColor.primaryColor,
            semanticLabel: 'backtopage'.tr(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor:
            notifier.isDark
                ? AppBarColor.fourthColor
                : AppBarColor.secondaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: ListView(
          children:
              ThemeModeOption.values.map((option) {
                IconData icon;
                String label;

                switch (option) {
                  case ThemeModeOption.light:
                    icon = Icons.light_mode;
                    label = "light_theme".tr();
                    break;
                  case ThemeModeOption.dark:
                    icon = Icons.dark_mode;
                    label = "dark_theme".tr();
                    break;
                  case ThemeModeOption.system:
                    icon = Icons.settings;
                    label = "system_theme".tr();
                    break;
                }

                return RadioListTile<ThemeModeOption>(
                  title: Text(label, style: context.bodyMediumFont),
                  secondary: Icon(
                    icon,
                    color: IconColor.primaryColor,
                    semanticLabel: "radio_icon".tr(),
                  ),
                  activeColor:
                      notifier.isDark
                          ? IconColor.primaryColor
                          : IconColor.fourthColor,
                  value: option,
                  groupValue: notifier.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      notifier.changeTheme(value);
                    }
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
