import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/controller/locale_controller.dart';
import 'package:cltxpj/controller/notification_controller.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/services/notification_service.dart';
import 'package:cltxpj/view/app_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_10y.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
        Locale('es'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en-US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationController()),
          ChangeNotifierProvider(create: (_) => LocaleController()),
          ChangeNotifierProvider(create: (_) => CalculatorController()),
          ChangeNotifierProvider(create: (_) => UiProvider()..init()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context, UiProvider notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CLT X PJ',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: AppPage(),
          themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
        );
      },
    );
  }
}
