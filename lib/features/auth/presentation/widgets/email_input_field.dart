import 'package:flutter/material.dart';
import 'package:laundry_customer_app/core/theme/app_colors.dart';
import 'package:laundry_customer_app/features/auth/presentation/widgets/custom_text_field.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final bool enabled;
  final bool autoFocus;

  const EmailInputField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.label = 'Email',
    this.hint = 'contoh@email.com',
    this.enabled = true,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      label: label!,
      hint: hint,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator ?? _defaultValidator,
      enabled: enabled,
      autoFocus: autoFocus,
      prefixIcon: const Icon(Icons.email_outlined, size: 24, color: AppColors.customPrimaryBlue),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!_isValidEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
