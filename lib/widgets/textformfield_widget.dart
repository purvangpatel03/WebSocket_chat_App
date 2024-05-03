import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final Widget? suffixIcon;
  final int? maxLine;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool? obscureText;

  const TextFormFieldWidget({
    super.key,
    this.validator,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.maxLine,
    this.keyboardType,
    this.onChanged,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        obscureText: obscureText ?? false,
        maxLines: maxLine,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        cursorColor: Colors.grey.shade600,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade600, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade600, width: 2),
          ),
        ),
      ),
    );
  }
}
