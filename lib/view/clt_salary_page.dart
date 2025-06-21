import 'package:cltxpj/controller/clt_controller.dart';
import 'package:cltxpj/features/app_theme.dart';
import 'package:cltxpj/features/theme_provider.dart';
import 'package:cltxpj/utils/currency_format_helper.dart';
import 'package:cltxpj/view/components/custom_button.dart';
import 'package:cltxpj/view/components/result_clt_dialog.dart';
import 'package:cltxpj/view/components/input_field.dart';
import 'package:cltxpj/view/components/show_dialog_error.dart';
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
  return Consumer2<UiProvider, CltController>(
    builder: (context, notifier, controller, child) {
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
                      label: 'salary_clt'.tr(),
                      controller: controller.cltSalaryController,
                      icon: Icons.work,
                      maxWidth: maxWidth,
                      onChanged: (_) => controller.calculate(),
                    ),
                    InputField(
                      label: 'benefits_clt'.tr(),
                      controller: controller.cltBenefitsController,
                      icon: Icons.card_giftcard,
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
                        final controller = context.read<CltController>();

                        if (controller.hasValidInput) {
                          ResultCltDialog.show(context, currencyFormat);
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
