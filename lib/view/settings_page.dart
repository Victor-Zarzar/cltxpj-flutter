import 'package:cltxpj/controller/locale_controller.dart';
import 'package:cltxpj/controller/notification_controller.dart';
import 'package:cltxpj/features/app_assets.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/theme_page.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final notificationController = Provider.of<NotificationController>(context);
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                notifier.isDark
                    ? AppBarColor.fourthColor
                    : AppBarColor.secondaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('settings'.tr(), style: context.h1),
          ),
          body: Container(
            color:
                notifier.isDark
                    ? BackGroundColor.fourthColor
                    : BackGroundColor.primaryColor,
            child: SizedBox(
              height: myHeight,
              width: myWidth,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ListTile(
                      leading: Icon(
                        Icons.translate,
                        color: IconColor.primaryColor,
                        semanticLabel: "translate_icon".tr(),
                      ),
                      title: Text(
                        'language'.tr(),
                        style: context.bodyMediumFont,
                      ),
                      trailing: PopupMenuButton<Locale>(
                        color:
                            notifier.isDark
                                ? PopupMenuColor.fourthColor
                                : PopupMenuColor.thirdColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.language,
                              color: IconColor.primaryColor,
                              semanticLabel: "language_icon".tr(),
                            ),
                            const SizedBox(width: 4),
                            Text('english'.tr(), style: context.bodyMediumFont),
                            Icon(
                              Icons.arrow_drop_down,
                              color: IconColor.primaryColor,
                              semanticLabel: "arrow_drop_icon".tr(),
                            ),
                          ],
                        ),
                        onSelected: (Locale locale) {
                          Provider.of<LocaleController>(
                            context,
                            listen: false,
                          ).changeLanguage(context, locale);
                        },
                        itemBuilder:
                            (BuildContext context) => [
                              PopupMenuItem(
                                value: const Locale('en', 'US'),
                                child: Row(
                                  children: [
                                    EN.asset(),
                                    const SizedBox(width: 8),
                                    Text(
                                      'english'.tr(),
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: TextColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: const Locale('pt', 'BR'),
                                child: Row(
                                  children: [
                                    PTBR.asset(),
                                    const SizedBox(width: 8),
                                    Text(
                                      'portuguese'.tr(),
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: TextColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: const Locale('es'),
                                child: Row(
                                  children: [
                                    ES.asset(),
                                    const SizedBox(width: 8),
                                    Text(
                                      'spanish'.tr(),
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: TextColor.primaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      color: IconColor.primaryColor,
                      semanticLabel: "color_icon".tr(),
                    ),
                    title: Text('theme'.tr(), style: context.bodyMediumFont),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: IconColor.primaryColor,
                      semanticLabel: "arrow_forward_icon".tr(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ThemePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  if (!kIsWeb)
                    ListTile(
                      leading: Icon(
                        color: IconColor.primaryColor,
                        Icons.notification_important,
                        semanticLabel: 'about_icon'.tr(),
                        size: 20,
                      ),
                      title: Text(
                        'notifications'.tr(),
                        style: context.bodyMediumFont,
                      ),
                      trailing: Switch(
                        value: notificationController.notificationsEnabled,
                        onChanged: notificationController.toggleNotifications,
                        activeColor: SwitchColor.inactiveThumb,
                        inactiveThumbColor:
                            notifier.isDark
                                ? SwitchColor.fiveColor
                                : SwitchColor.fourthColor,
                        activeTrackColor:
                            notifier.isDark
                                ? SwitchColor.darkInactiveTrack
                                : SwitchColor.activeThumb.withValues(
                                  alpha: 0.5,
                                ),
                        inactiveTrackColor:
                            notifier.isDark
                                ? SwitchColor.inactiveThumb
                                : SwitchColor.activeThumb,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
