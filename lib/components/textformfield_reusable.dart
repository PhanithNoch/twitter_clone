import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldReusable extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final Function onTab;
  final EdgeInsetsGeometry? padding;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? readOnly;
  final bool? autofocus;
  final FocusNode? focusNode;
  TextFormFieldReusable({
    this.labelText,
    this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
    required this.onTab,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.readOnly,
    this.autofocus,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLength: maxLines,
        minLines: minLines,
        autofocus: autofocus ?? false,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        onTap: () => onTab(),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: Icon(suffixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
