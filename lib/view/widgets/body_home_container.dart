import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/view/components/custom_button.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/widgets/responsive_extension.dart';
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
  final Function(TextEditingController) formatCurrency;
  final Function(String) parseCurrency;
  final String? Function(String?) validator;
  final VoidCallback onCalculatePressed;
  final double padding;

  const BodyContainer({
    super.key,
    required this.formKey,
    required this.salaryCltController,
    required this.salaryPjController,
    required this.benefitsController,
    required this.taxesPjController,
    required this.accountantFeeController,
    required this.inssPjController,
    required this.formatCurrency,
    required this.parseCurrency,
    required this.validator,
    required this.onCalculatePressed,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              padding,
              padding + 40,
              padding,
              padding,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
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
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputField(
                            label: 'salary_clt'.tr(),
                            controller: salaryCltController,
                            validator: validator,
                            icon: Icons.money,
                            maxWidth: 400,
                            prefix: Text('R\$ ', style: context.bodySmall),
                            onChanged:
                                (_) => formatCurrency(salaryCltController),
                          ),
                          InputField(
                            label: 'salary_pj'.tr(),
                            controller: salaryPjController,
                            validator: validator,
                            icon: Icons.money,
                            maxWidth: 400,
                            prefix: Text('R\$ ', style: context.bodySmall),
                            onChanged:
                                (_) => formatCurrency(salaryPjController),
                          ),
                          InputField(
                            label: 'benefits_clt'.tr(),
                            controller: benefitsController,
                            validator: validator,
                            icon: Icons.card_giftcard,
                            maxWidth: 400,
                            prefix: Text('R\$ ', style: context.bodySmall),
                            onChanged:
                                (_) => formatCurrency(benefitsController),
                          ),
                          InputField(
                            label: 'accountant_fee'.tr(),
                            controller: accountantFeeController,
                            validator: validator,
                            icon: Icons.receipt,
                            maxWidth: 400,
                            prefix: Text('R\$ ', style: context.bodySmall),
                            onChanged:
                                (_) => formatCurrency(accountantFeeController),
                          ),
                          InputField(
                            label: 'inss_pj'.tr(),
                            controller: inssPjController,
                            validator: validator,
                            icon: Icons.percent,
                            maxWidth: 400,
                          ),
                          InputField(
                            label: 'taxes_pj'.tr(),
                            controller: taxesPjController,
                            validator: validator,
                            icon: Icons.percent,
                            maxWidth: 400,
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            maxWidth: 400,
                            color:
                                notifier.isDark
                                    ? ButtonColor.fourthColor
                                    : ButtonColor.primaryColor,
                            onPressed: onCalculatePressed,
                            text: 'calculate'.tr(),
                          ),
                        ],
                      ),
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
