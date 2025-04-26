import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.hasSuffixIcon = false,
    this.controller,
    this.isPasswordVisible = true,
    this.onEyeTap,
    this.validator,
  });
  final String text;
  final bool hasSuffixIcon;
  final bool? isPasswordVisible;
  final TextEditingController? controller;
  final void Function()? onEyeTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,

      controller: controller,
      validator: validator,
      style: AppStyles.styleMedium18,
      obscureText: !(isPasswordVisible ?? false),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        suffixIcon:
            hasSuffixIcon == true
                ? isPasswordVisible == false
                    ? GestureDetector(
                      onTap: onEyeTap,
                      child: Icon(
                        Icons.visibility_off_rounded,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    )
                    : GestureDetector(
                      onTap: onEyeTap,
                      child: Icon(
                        Icons.visibility,
                        color: Colors.grey[500],
                        size: 20,
                      ),
                    )
                : null,
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
