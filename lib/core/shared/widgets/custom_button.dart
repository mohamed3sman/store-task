import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final bool? isLoading;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.primaryColor,
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child:
          isLoading == false
              ? Text(
                text,
                style: AppStyles.styleMedium16.copyWith(color: Colors.white),
              )
              : SizedBox(
                width: 24,
                height: 24,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
    );
  }
}
