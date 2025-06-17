import 'package:cltxpj/controller/pj_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/components/pj_chart.dart';
import 'package:cltxpj/view/widgets/responsive.dart';
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
      body: Responsive(
        mobile: _buildContent(
          context,
          maxWidth: 350,
          padding: 20,
          minHeight: 550,
        ),
        tablet: _buildContent(
          context,
          maxWidth: 600,
          padding: 30,
          minHeight: 600,
        ),
        desktop: _buildContent(
          context,
          maxWidth: 700,
          minHeight: 600,
          padding: 50,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required double maxWidth,
    required double padding,
    required double minHeight,
  }) {
    final controller = context.read<PjController>();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth, minHeight: minHeight),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                    label: 'salary_pj'.tr(),
                    controller: controller.salaryController,
                    validator: (v) => null,
                    icon: Icons.business,
                    maxWidth: maxWidth,
                    onChanged: (_) => controller.calculateDebounced(),
                  ),
                  InputField(
                    label: 'taxes_pj'.tr(),
                    controller: controller.taxController,
                    validator: (v) => null,
                    icon: Icons.percent,
                    maxWidth: maxWidth,
                    onChanged: (_) => controller.calculateDebounced(),
                  ),
                  InputField(
                    label: 'accountant_fee'.tr(),
                    controller: controller.accountantController,
                    validator: (v) => null,
                    icon: Icons.receipt_long,
                    maxWidth: maxWidth,
                    onChanged: (_) => controller.calculateDebounced(),
                  ),
                  InputField(
                    label: 'inss_pj'.tr(),
                    controller: controller.inssController,
                    validator: (v) => null,
                    icon: Icons.shield,
                    maxWidth: maxWidth,
                    onChanged: (_) => controller.calculateDebounced(),
                  ),
                  const SizedBox(height: 0),
                  const PjChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
