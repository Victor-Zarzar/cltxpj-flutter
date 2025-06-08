import 'package:cltxpj/controller/locale_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/about_page.dart';
import 'package:cltxpj/view/home_page.dart';
import 'package:cltxpj/view/settings_page.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/tabs/gf_tabbar.dart';
import 'package:getwidget/components/tabs/gf_tabbar_view.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with TickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Consumer<LocaleController>(
      builder: (context, languageProvider, child) {
        final notifier = context.watch<UiProvider>();
        double myHeight = MediaQuery.of(context).size.height;
        double myWidth = MediaQuery.of(context).size.width;
        return Scaffold(
          body: SizedBox(
            key: ValueKey(currentLocale),
            height: myHeight,
            width: myWidth,
            child: GFTabBarView(
              key: _tabBarKey,
              controller: tabController,
              children: const <Widget>[HomePage(), AboutPage(), SettingsPage()],
            ),
          ),
          bottomNavigationBar: GFTabBar(
            tabBarHeight: 90,
            length: 3,
            controller: tabController,
            tabBarColor:
                notifier.isDark
                    ? TabBarColor.fourthColor
                    : TabBarColor.primaryColor,
            labelColor: TextColor.primaryColor,
            indicatorColor: TextColor.primaryColor,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.money,
                  size: 21,
                  color: IconColor.primaryColor,
                  semanticLabel: "money_icon".tr(),
                ),
                child: Text('home'.tr(), style: context.footerMediumFont),
              ),
              Tab(
                icon: Icon(
                  Icons.info,
                  size: 21,
                  color: IconColor.primaryColor,
                  semanticLabel: "info_icon".tr(),
                ),
                child: Text('about'.tr(), style: context.footerMediumFont),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  size: 21,
                  color: IconColor.primaryColor,
                  semanticLabel: "settings_icon".tr(),
                ),
                child: Text('settings'.tr(), style: context.footerMediumFont),
              ),
            ],
          ),
        );
      },
    );
  }
}
