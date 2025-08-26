import 'package:flutter/material.dart';
import 'package:laundry_customer_app/core/theme/app_colors.dart';
import 'package:laundry_customer_app/features/auth/presentation/widgets/custom_text_field.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final bool enabled;
  final bool autoFocus;

  const NameInputField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.label = 'Nama Lengkap',
    this.hint = 'Masukkan nama lengkap Anda',
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
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator ?? _defaultValidator,
      enabled: enabled,
      autoFocus: autoFocus,
      prefixIcon: const Icon(Icons.person_outline, size: 24, color: AppColors.customPrimaryBlue),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 2) {
      return 'Nama minimal 2 karakter';
    }
    return null;
  }
}
