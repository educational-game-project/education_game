import 'package:education_game/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FontsEnum {
  chubbyCrayon,
  clapHand;

  String get getFonts {
    switch (this) {
      case chubbyCrayon:
        return AppFonts.chubbyCrayon;
      case clapHand:
        return AppFonts.clapHand;
      default:
        return AppFonts.chubbyCrayon;
    }
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontsEnum,
    this.overflow,
    this.maxLines,
    this.textAlign,
  });

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontsEnum? fontsEnum;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 12.sp,
        color: color ?? Colors.white,
        fontFamily: fontsEnum?.getFonts ?? AppFonts.chubbyCrayon,
        fontWeight: fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
