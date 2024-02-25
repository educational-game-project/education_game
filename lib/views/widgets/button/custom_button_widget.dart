import 'package:education_game/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends HookWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.color,
    this.activeColor,
    this.borderRadius,
    this.elevation,
  });
  final Function() onTap;
  final Widget child;
  final Color? color;
  final Color? activeColor;
  final BorderRadius? borderRadius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    var colorMaterial = color ?? AppColors.primary500;
    var colorInk = activeColor ?? Colors.white.withOpacity(0.6);

    return Material(
      color: colorMaterial,
      borderRadius: borderRadius,
      elevation: elevation ?? 4.sp,
      child: InkWell(
        onTap: onTap,
        splashColor: colorInk,
        focusColor: colorInk,
        hoverColor: colorInk,
        highlightColor: colorInk,
        overlayColor: MaterialStatePropertyAll(colorInk),
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
