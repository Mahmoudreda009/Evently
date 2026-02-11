import 'package:evently_assignment/ui/utils/app_colors.dart';
import 'package:evently_assignment/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hint;
  final bool isPasswordField;
  final int? maxLines;
  final TextEditingController? controller;

  const AppTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hint,
    this.isPasswordField = false,
    this.maxLines = 1, this.controller,
  });
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
    );
    return TextField(
      maxLines: maxLines ?? 1,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: prefixIcon,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: suffixIcon,
        ),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        border: border,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        errorBorder: border,
        fillColor: Theme.of(context).cardColor,
        prefixIconConstraints: BoxConstraints(minWidth: 48, minHeight: 48),
        suffixIconConstraints: BoxConstraints(minWidth: 48, minHeight: 48),
        filled: true,
      ),
      obscureText: isPasswordField,
    );
  }
}
