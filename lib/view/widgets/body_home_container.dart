import 'package:cltxpj/controller/calculate_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/components/custom_button.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/components/show_dialog_error.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyContainer extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController salaryCltController;
  final TextEditingController salaryPjController;
  final TextEditingController benefitsController;
  final TextEditingController taxesPjController;
  final TextEditingController accountantFeeController;
  final TextEditingController inssPjController;
  final VoidCallback onCalculatePressed;
  final double padding;
  final double minHeight;
  final double maxWidth;

  const BodyContainer({
    super.key,
    required this.formKey,
    required this.salaryCltController,
    required this.salaryPjController,
    required this.benefitsController,
    required this.taxesPjController,
    required this.accountantFeeController,
    required this.inssPjController,
    required this.onCalculatePressed,
    required this.padding,
    required this.minHeight,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CalculatorController>();
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                  minHeight: minHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputField(
                          label: 'salary_clt'.tr(),
                          controller: controller.salaryCltController,
                          icon: Icons.money,
                          maxWidth: maxWidth,
                          onChanged: (_) => controller.calculate(),
                        ),
                        InputField(
                          label: 'salary_pj'.tr(),
                          controller: controller.salaryPjController,
                          icon: Icons.money,
                          maxWidth: maxWidth,
                          onChanged: (_) => controller.calculate(),
                        ),
                        InputField(
                          label: 'benefits_clt'.tr(),
                          controller: benefitsController,
                          icon: Icons.card_giftcard,
                          maxWidth: maxWidth,
                          onChanged: (_) => controller.calculate(),
                        ),
                        InputField(
                          label: 'accountant_fee'.tr(),
                          controller: controller.accountantFeeController,
                          icon: Icons.receipt,
                          maxWidth: maxWidth,
                          onChanged: (_) => controller.calculate(),
                        ),
                        InputField(
                          label: 'inss_pj'.tr(),
                          controller: controller.inssPjController,
                          icon: Icons.percent,
                          maxWidth: maxWidth,
                          onChanged: (_) => controller.calculate(),
                        ),
                        InputField(
                          label: 'taxes_pj'.tr(),
                          controller: controller.taxesPjController,
                          icon: Icons.percent,
                          maxWidth: maxWidth,
                          onChanged: (_) => controller.calculate(),
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
                            final controller =
                                context.read<CalculatorController>();
                            if (!controller.hasValidInput) {
                              ShowDialogError.show(
                                context,
                                title: 'error'.tr(),
                                child: Text('fill_fields_to_see_chart'.tr()),
                              );
                              return;
                            }
                            onCalculatePressed();
                          },
                          text: 'calculate'.tr(),
                        ),
                      ],
                    ),
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
