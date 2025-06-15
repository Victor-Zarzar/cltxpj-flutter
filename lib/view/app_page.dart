import 'package:cltxpj/controller/locale_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/about_page.dart';
import 'package:cltxpj/view/clt_salary_page.dart';
import 'package:cltxpj/view/home_page.dart';
import 'package:cltxpj/view/pj_salary_page.dart';
import 'package:cltxpj/view/settings_page.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final notifier = context.watch<UiProvider>();

    return Consumer<LocaleController>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          body: TabBarView(
            key: ValueKey(currentLocale),
            controller: tabController,
            children: const [
              HomePage(),
              Cltpage(),
              Pjpage(),
              AboutPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: Material(
            color:
                notifier.isDark
                    ? TabBarColor.fourthColor
                    : TabBarColor.primaryColor,
            child: TabBar(
              controller: tabController,
              labelColor: TextColor.primaryColor,
              indicatorColor: TextColor.primaryColor,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.calculate,
                    semanticLabel: "money_icon".tr(),
                    color: IconColor.primaryColor,
                  ),
                  child: Text(
                    'home'.tr(),
                    style: context.footerMediumFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.work,
                    semanticLabel: "money_icon".tr(),
                    color: IconColor.primaryColor,
                  ),
                  child: Text(
                    'Clt',
                    style: context.footerMediumFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.business,
                    semanticLabel: "money_icon".tr(),
                    color: IconColor.primaryColor,
                  ),
                  child: Text(
                    'Pj',
                    style: context.footerMediumFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.info,
                    semanticLabel: "info_icon".tr(),
                    color: IconColor.primaryColor,
                  ),
                  child: Text(
                    'about'.tr(),
                    style: context.footerMediumFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                    semanticLabel: "settings_icon".tr(),
                    color: IconColor.primaryColor,
                  ),
                  child: Text(
                    'settings'.tr(),
                    style: context.footerMediumFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
