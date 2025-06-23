import 'package:cltxpj/controller/pj_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/utils/currency_format_helper.dart';
import 'package:cltxpj/view/components/custom_button.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/components/result_pj_dialog.dart';
import 'package:cltxpj/view/components/show_dialog_error.dart';
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
                ? AppBarColor.thirdColor
                : AppBarColor.secondaryColor,
      ),
      body: Responsive(
        mobile: _buildContent(
          context,
          maxWidth: 370,
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
    return Consumer2<UiProvider, PjController>(
      builder: (context, notifier, controller, child) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              minHeight: minHeight,
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:
                              notifier.isDark
                                  ? CardColor.primaryColor
                                  : CardColor.secondaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  notifier.isDark
                                      ? Colors.black.withValues(alpha: 0.3)
                                      : Colors.grey.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              InputField(
                                label: 'salary_pj'.tr(),
                                controller: controller.salaryController,
                                icon: Icons.business_center_rounded,
                                maxWidth: maxWidth,
                                onChanged: (_) => controller.calculate(),
                              ),
                              InputField(
                                label: 'taxes_pj'.tr(),
                                controller: controller.taxController,
                                icon: Icons.account_balance_rounded,
                                maxWidth: maxWidth,
                                onChanged: (_) => controller.calculate(),
                              ),
                              InputField(
                                label: 'accountant_fee'.tr(),
                                controller: controller.accountantController,
                                icon: Icons.receipt_long_rounded,
                                maxWidth: maxWidth,
                                onChanged: (_) => controller.calculate(),
                              ),
                              InputField(
                                label: 'inss_pj'.tr(),
                                controller: controller.inssController,
                                icon: Icons.security_rounded,
                                maxWidth: maxWidth,
                                onChanged: (_) => controller.calculate(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        animatedGradient: true,
                        fullWidth: true,
                        height: 42,
                        maxWidth: maxWidth,
                        color:
                            notifier.isDark
                                ? ButtonColor.fourthColor
                                : ButtonColor.primaryColor,
                        onPressed: () {
                          final controller = context.read<PjController>();

                          if (controller.hasValidInput) {
                            ResultPjtDialog.show(context, currencyFormat);
                          } else {
                            ShowDialogError.show(
                              context,
                              title: 'error'.tr(),
                              child: Text('fill_fields_to_see_chart'.tr()),
                            );
                          }
                        },
                        text: 'calculate'.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
