import 'package:fake_store/core/shared/constants/app_colors.dart';
import 'package:fake_store/core/shared/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final void Function()? onCloseIconTap;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onCloseIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        cursorColor: Colors.orangeAccent,
        controller: controller,
        onChanged: onChanged,
        style: AppStyles.styleRegular16.copyWith(color: AppColors.primaryColor),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12),
          suffixIcon: GestureDetector(
            onTap: onCloseIconTap,
            child: Icon(Icons.close_rounded),
          ),
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
