import 'package:cltxpj/controller/pj_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/components/pj_chart.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pjpage extends StatefulWidget {
  const Pjpage({super.key});

  @override
  State<Pjpage> createState() => _PjpageState();
}

class _PjpageState extends State<Pjpage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<PjController>();
    final notifier = Provider.of<UiProvider>(context);
    return Scaffold(
      backgroundColor:
          notifier.isDark
              ? BackGroundColor.fourthColor
              : BackGroundColor.primaryColor,
      appBar: AppBar(
        title: Text("pj_title".tr(), style: context.h1),
        centerTitle: true,
        backgroundColor:
            notifier.isDark
                ? AppBarColor.fourthColor
                : AppBarColor.secondaryColor,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, minHeight: 650),
          child: Card(
            color:
                notifier.isDark
                    ? CardColor.thirdColor
                    : CardColor.secondaryColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputField(
                      label: 'salary_pj'.tr(),
                      controller: controller.salaryController,
                      validator: (v) => null,
                      icon: Icons.business,
                      maxWidth: 400,
                      onChanged: (_) => controller.calculateDebounced(),
                    ),
                    InputField(
                      label: 'taxes_pj'.tr(),
                      controller: controller.taxController,
                      validator: (v) => null,
                      icon: Icons.percent,
                      maxWidth: 400,
                      onChanged: (_) => controller.calculateDebounced(),
                    ),
                    InputField(
                      label: 'accountant_fee'.tr(),
                      controller: controller.accountantController,
                      validator: (v) => null,
                      icon: Icons.receipt_long,
                      maxWidth: 400,
                      onChanged: (_) => controller.calculateDebounced(),
                    ),
                    InputField(
                      label: 'inss_pj'.tr(),
                      controller: controller.inssController,
                      validator: (v) => null,
                      icon: Icons.shield,
                      maxWidth: 400,
                      onChanged: (_) => controller.calculateDebounced(),
                    ),
                    const SizedBox(height: 10),
                    PjChart(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
