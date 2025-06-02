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
                notifier.isDark ? AppTheme.fourthColor : AppTheme.primaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'settings'.tr(),
              style: GoogleFonts.jetBrainsMono(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color:
                      notifier.isDark
                          ? TextColor.secondaryColor
                          : TextColor.primaryColor,
                ),
              ),
            ),
          ),
          body: Container(
            color:
                notifier.isDark
                    ? BackGround.fourthColor
                    : BackGround.primaryColor,
            child: SizedBox(
              height: myHeight,
              width: myWidth,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ListTile(
                      trailing: Switch(
                        activeColor: SwitchColor.primaryColor,
                        inactiveTrackColor: SwitchColor.secondaryColor,
                        value: notifier.isDark,
                        onChanged: (value) => notifier.changeTheme(),
                      ),
                      leading: Icon(
                        Icons.dark_mode,
                        semanticLabel: 'notifications_icon'.tr(),
                        size: 20,
                      ),
                      title: Text(
                        'darkmode'.tr(),
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                notifier.isDark
                                    ? TextColor.secondaryColor
                                    : TextColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: IconColor.primaryColor,
                      semanticLabel: 'language_icon'.tr(),
                    ),
                    title: Text(
                      'language'.tr(),
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: TextColor.primaryColor,
                        ),
                      ),
                    ),
                    trailing: PopupMenuButton<Locale>(
                      color: AppTheme.thirdColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                        color: TextColor.primaryColor,
                        semanticLabel: 'arrow_icon'.tr(),
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
                                  const SizedBox(width: 10),
                                  Text(
                                    'english'.tr(),
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: TextColor.primaryColor,
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
                                  const SizedBox(width: 10),
                                  Text(
                                    'portuguese'.tr(),
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: TextColor.primaryColor,
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
                                  const SizedBox(width: 10),
                                  Text(
                                    'spanish'.tr(),
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: TextColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  ),
                  if (!kIsWeb)
                    ListTile(
                      leading: Icon(
                        Icons.notification_important,
                        semanticLabel: 'about_icon'.tr(),
                        size: 20,
                      ),
                      title: Text(
                        'notifications'.tr(),
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color:
                                notifier.isDark
                                    ? TextColor.secondaryColor
                                    : TextColor.primaryColor,
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
