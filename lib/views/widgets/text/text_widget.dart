import 'package:education_game/utils/fonts.dart';
import 'package:flutter/material.dart';

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
  });

  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final FontsEnum? fontsEnum;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? (size.height * 0.08),
        color: color ?? Colors.white,
        fontFamily: fontsEnum?.getFonts ?? AppFonts.chubbyCrayon,
        fontWeight: fontWeight,
      ),
    );
  }
}
