import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';

class CustomReactiveTextField extends StatelessWidget {
  final String formControlName;
  final String label;
  final bool obscureText;
  final VoidCallback? onEyeTap;
  final bool showEyeIcon;
  final Map<String, String Function(Object)>? validationMessages;

  const CustomReactiveTextField({
    super.key,
    required this.formControlName,
    required this.label,
    this.obscureText = false,
    this.onEyeTap,
    this.showEyeIcon = false,
    this.validationMessages,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: formControlName,
      style: AppStyles.styleRegular16,
      obscureText: obscureText,
      cursorColor: AppColors.mediumColor,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppStyles.styleMedium18.copyWith(
          color: AppColors.primaryColor, // اللون الطبيعي للـ label لما مش فوكست
        ),
        floatingLabelStyle: AppStyles.styleMedium18.copyWith(
          color: AppColors.primaryColor, // اللون لما الفوكست بيحصل
        ),
        contentPadding: EdgeInsets.zero,
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor, // لون البوردر لما يكون focused
            width: 2,
          ),
        ),
        suffixIcon:
            showEyeIcon
                ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: onEyeTap,
                )
                : null,
      ),

      validationMessages: validationMessages,
    );
  }
}
