import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';


class JBButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? type;
  final Widget? icon;
  final Widget? child;

  const JBButton({super.key,
    required this.text,
    required this.onPressed,
    this.type,
    this.icon,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    JBButtonProperties properties;
    if(!type.isNullOrEmpty){
      properties = context.isDarkMode
          ? (JBConfig.buttons["$type:dark"] ?? JBConfig.buttons[type]!)
          : (JBConfig.buttons["$type:light"] ?? JBConfig.buttons[type]!);
    }else{
      properties = JBConfig.defaultButton;
    }


    final borderRadius = properties.borderRadius ??
        BorderRadius.circular(properties.borderRadiusAll ?? 8);

    final buttonContent = child ?? Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: (properties.textStyle ?? textThemes?.bodyMedium)?.c(properties.textColor),
        ),
      ],
    );

    final button = InkWell(
      onTap: onPressed,
      borderRadius: borderRadius,
      child: Ink(
        padding: properties.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: properties.gradient,
          color: properties.gradient == null ? properties.color ?? colors?.primary : null,
          borderRadius: borderRadius,
          border: properties.borderColor != null
              ? Border.all(
            color: properties.borderColor!,
            width: properties.borderWidth ?? 1.5,
          )
              : null,
        ),
        child: buttonContent,
      ),
    );

    return Material(
      type: MaterialType.transparency,
      elevation: properties.elevation ?? 2,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: properties.minWidth ?? 64,
          minHeight: properties.height ?? 40,
        ),
        child: button,
      ),
    );

  }
}