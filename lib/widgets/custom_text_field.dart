import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final bool isObsecure;
  final int? maxLines;
  final TextInputType? type;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    super.key,
    required this.title,
    this.hintText,
    this.prefix,
    this.suffix,
    this.controller,
    this.validation,
    this.isObsecure = false,
    this.maxLines = 1,
    this.type,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return TextFormField(
      
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      cursorColor: AppColors.primaryColor,
      keyboardType: type,
      maxLines: maxLines,
      obscureText: isObsecure,
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? title,
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(
            start: width * 0.025,
            end: width * 0.02,
          ),
          child: prefix,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0),
        suffixIcon: suffix,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),

      ),
      
    );
    
  }
}
