import 'package:cltxpj/controller/locale_controller.dart';
import 'package:cltxpj/controller/notification_controller.dart';
import 'package:cltxpj/features/app_assets.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
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
          appBar: GFAppBar(
            backgroundColor:
                notifier.isDark
                    ? AppBarColor.fourthColor
                    : AppBarColor.secondaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'settings'.tr(),
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: TextColor.primaryColor,
                ),
              ),
            ),
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
                      ),
                      title: Text(
                        'language'.tr(),
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: TextColor.primaryColor,
                          ),
                        ),
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
                            Icon(Icons.language, color: IconColor.primaryColor),
                            const SizedBox(width: 4),
                            Text(
                              'english'.tr(),
                              style: GoogleFonts.jetBrainsMono(
                                textStyle: TextStyle(
                                  color: TextColor.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: IconColor.primaryColor,
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
                    trailing: Switch(
                      activeColor: SwitchColor.primaryColor,
                      inactiveTrackColor: SwitchColor.secondaryColor,
                      value: notifier.isDark,
                      onChanged: (value) => notifier.changeTheme(),
                    ),
                    leading: Icon(
                      Icons.dark_mode,
                      color: IconColor.primaryColor,
                      semanticLabel: 'notifications_icon'.tr(),
                      size: 20,
                    ),
                    title: Text(
                      'darkmode'.tr(),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: TextColor.primaryColor,
                        ),
                      ),
                    ),
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
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: TextColor.primaryColor,
                          ),
                        ),
                      ),
                      trailing: Switch(
                        value: notificationController.notificationsEnabled,
                        onChanged: notificationController.toggleNotifications,
                        activeColor:
                            notifier.isDark
                                ? SwitchColor.darkActiveColor
                                : SwitchColor.thirdColor,
                        inactiveTrackColor:
                            notifier.isDark
                                ? SwitchColor.darkInactiveTrackColor
                                : SwitchColor.secondaryColor,
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
