import 'package:cltxpj/controller/clt_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/components/clt_chart.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/widgets/responsive.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cltpage extends StatefulWidget {
  const Cltpage({super.key});

  @override
  State<Cltpage> createState() => _CltpageState();
}

class _CltpageState extends State<Cltpage> {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<UiProvider>(context);

    return Scaffold(
      backgroundColor:
          notifier.isDark
              ? BackGroundColor.fourthColor
              : BackGroundColor.primaryColor,
      appBar: AppBar(
        title: Text("clt_title".tr(), style: context.h1),
        centerTitle: true,
        backgroundColor:
            notifier.isDark
                ? AppBarColor.fourthColor
                : AppBarColor.secondaryColor,
      ),
      body: Responsive(
        mobile: _buildContent(
          context,
          maxWidth: 360,
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
          minHeight: 560,
          padding: 50,
        ),
      ),
    );
  }
}

Widget _buildContent(
  BuildContext context, {
  required double maxWidth,
  required double padding,
  required double minHeight,
}) {
  final controller = context.read<CltController>();
  final notifier = Provider.of<UiProvider>(context);

  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, minHeight: minHeight),
      child: Card(
        color:
            notifier.isDark ? CardColor.thirdColor : CardColor.secondaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputField(
                  label: 'salary_clt'.tr(),
                  controller: controller.salaryController,
                  validator: (v) => null,
                  icon: Icons.work,
                  maxWidth: maxWidth,
                  onChanged: (_) => controller.calculateDebounced(),
                ),
                InputField(
                  label: 'benefits_clt'.tr(),
                  controller: controller.benefitsController,
                  validator: (v) => null,
                  icon: Icons.card_giftcard,
                  maxWidth: maxWidth,
                  onChanged: (_) => controller.calculateDebounced(),
                ),
                const SizedBox(height: 20),
                const CltChart(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
