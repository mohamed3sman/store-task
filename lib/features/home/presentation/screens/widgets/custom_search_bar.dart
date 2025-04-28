import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        cursorColor: AppColors.primaryColor,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: AppStyles.styleRegular16.copyWith(
            color: Color(0xffAAAAAA),
          ),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
