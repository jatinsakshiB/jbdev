import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';

import '../../helpers/jb_text_controller.dart';

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
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final Function(String)? onTypingComplete;
  final int typingDebounce;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final double? height;
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
    this.onSubmitted,
    this.onEditingComplete,
    this.onTypingComplete,
    this.typingDebounce = 500,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    JBTextFieldProperties properties;
    Timer? debounce;
    if(!type.isNullOrEmpty){
      properties = context.isDarkMode
          ? (JBConfig.textFields["$type:dark"] ?? JBConfig.textFields[type]!)
          : (JBConfig.textFields["$type:light"] ?? JBConfig.textFields[type]!);
    }else{
      properties = JBConfig.defaultTextField;
    }

    var borderRadius = properties.borderRadius ?? BorderRadius.circular(properties.borderRadiusAll ?? 16);
    var inputDecoration = InputDecoration(
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
    );
    Widget textField({JBTextFieldState? state}) =>  TextField(
      controller: controller,
      readOnly: readOnly,
      onChanged: (value){
        onChange?.call(value);

        if (debounce?.isActive ?? false) debounce!.cancel();
        debounce = Timer(Duration(milliseconds: typingDebounce), () {
          onTypingComplete?.call(value); // triggers only after user stops typing
        });
      },
      onTap: onTap,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      obscureText: state?.obscureText ?? false,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      enabled: state?.enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      style: (state?.enabled == false) ? (properties.disableTextStyle ?? Theme.of(context).textTheme.labelLarge)?.c(properties.disableTextColor) : (properties.textStyle ?? context.textThemes.bodyMedium)?.c(properties.textColor),
      cursorColor: properties.cursorColor,
      decoration: inputDecoration,
    ).withHeight(height ?? properties.height);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label!= null) ...[
          JBText(
            label!.replaceAll("*", "{${context.colors.error.toHex()}|*"),
            style: (properties.labelTextStyle ?? context.textThemes.bodyMedium)?.c(properties.labelTextColor),
          ),
          6.heightBox
        ],

        Material(
          elevation: properties.elevation ?? 0,
          borderRadius: borderRadius,
          color: Colors.transparent,
          child: controller == null ?  textField() : ValueListenableBuilder(
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
