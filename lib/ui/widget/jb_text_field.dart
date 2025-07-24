import 'package:flutter/material.dart';
import 'package:jbdev/extensions/context_extensions.dart';
import 'package:jbdev/extensions/num_extension.dart';
import 'package:jbdev/extensions/string_extensions.dart';
import 'package:jbdev/extensions/text_style_extension.dart';
import 'package:jbdev/extensions/widget_extensions.dart';
import 'package:jbdev/models/jb_text_field_properties.dart';

import '../../helpers/jb_text_controller.dart';
import '../../utils/jb_config.dart';

class JBTextField extends StatelessWidget {
  final JBTextController? controller;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final TextInputType keyboardType;
  final String? type;
  final int? maxLength;
  final int? maxLines;
  final bool readOnly;
  final Function(String)? onChange;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Function()? onTap;


  const JBTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.type,
    this.maxLength,
    this.maxLines,
    this.readOnly = false,
    this.onChange,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    JBTextFieldProperties properties;
    if(!type.isNullOrEmpty){
      properties = context.isDarkMode
          ? (JBConfig.textFields["$type:dark"] ?? JBConfig.textFields[type]!)
          : (JBConfig.textFields["$type:light"] ?? JBConfig.textFields[type]!);
    }else{
      properties = JBConfig.defaultTextField;
    }

    var borderRadius = properties.borderRadius ?? BorderRadius.circular(properties.borderRadiusAll ?? 16);

    Widget textField({JBTextFieldState? state}) =>  TextField(
      controller: controller,
      readOnly: readOnly,
      onChanged: onChange,
      onTap: onTap,
      obscureText: state?.obscureText ?? false,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      enabled: state?.enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      style: (properties.textStyle ?? context.textThemes.bodyMedium)?.c(properties.textColor),
      cursorColor: properties.cursorColor,
      decoration: InputDecoration(
        fillColor: properties.color,
        filled: properties.color != null,
        contentPadding: properties.padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: (properties.hintTextStyle ?? Theme.of(context).textTheme.labelLarge)?.c(properties.hintTextColor),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefix: prefix,
        suffix: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: properties.borderColor != null ? BorderSide(color: properties.borderColor!, width: properties.borderWidth ?? 2) : BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: properties.disabledBorderColor != null ? BorderSide(color: properties.disabledBorderColor!, width: properties.disabledBorderWidth ?? 2) : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: properties.focusedBorderColor != null ? BorderSide(color: properties.focusedBorderColor!, width: properties.focusedBorderWidth ?? 2) : BorderSide.none,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label!= null) ...[
          Text(
            label!,
            style: (properties.labelTextStyle ?? context.textThemes.bodyMedium)?.c(properties.labelTextColor),
          ),
          6.heightBox
        ],

        Material(
          elevation: properties.elevation ?? 0,
          borderRadius: borderRadius,
          color: Colors.transparent,
          child: controller == null ? textField() : ValueListenableBuilder(
              valueListenable: controller!.stateNotifier,
              builder: (context, state, _){
                return textField(state: state);
              }
          ),
        ),

        if (controller != null) ValueListenableBuilder(
            valueListenable: controller!.errorNotifier,
            builder: (_, error, __){
              return error == null ? const SizedBox() : Row(
                mainAxisAlignment: properties.errorAlignment ?? MainAxisAlignment.end,
                children: [
                  Text(
                    error,
                    style: (properties.errorTextStyle ?? context.textThemes.labelMedium?.error(context))?.c(properties.errorTextColor),
                    textAlign: TextAlign.end,
                  ),
                ],
              ).withTopPadding(4);
            }
        ),
      ],
    );
  }
}
