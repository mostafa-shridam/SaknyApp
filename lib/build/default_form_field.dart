import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';

// ignore: must_be_immutable
class DefaultFormField extends StatelessWidget {
  DefaultFormField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.prefix,
    this.maxLength,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.hintText,
    this.icon,
    this.maxLines,
    required this.controller,
    this.validator,
    this.iconColor,
  });

  bool? obscureText;
  int? maxLength;
  int? maxLines;
  String? labelText;
  String? hintText;
  Color? iconColor;
  Widget? prefixIcon, suffixIcon, icon, prefix;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      minLines: 1,
      cursorColor: defaultColor,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        hoverColor: defaultColor,
        suffixIconColor: defaultColor,
        prefixIconColor: defaultColor,
        iconColor: iconColor,
        prefix: prefix,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        focusColor: defaultColor,
        fillColor: defaultColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
          gapPadding: 8,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
