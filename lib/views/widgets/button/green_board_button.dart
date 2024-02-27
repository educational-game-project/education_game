import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

enum TextButtonEnum {
  mulai,
  lanjut,
  ulangi,
  selanjutnya,
  cek,
  tidak,
  mainLagi;

  String get getTextButton {
    switch (this) {
      case mainLagi:
        return 'Main Lagi';
      default:
        return name.capitalize ?? '';
    }
  }
}

class GreenBoardButton extends StatelessWidget {
  const GreenBoardButton({
    super.key,
    this.onTap,
    this.textButtonEnum = TextButtonEnum.lanjut,
    this.height = 46,
    this.width = 60,
    this.showWood = false,
  });
  final Function()? onTap;
  final TextButtonEnum textButtonEnum;
  final double height;
  final double width;
  final bool showWood;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showWood ? height.sp : null,
      width: showWood ? width.sp : null,
      child: Stack(
        children: [
          if (showWood)
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.network(
                AppImages.lineWood,
                height: height.sp * 0.8,
              ),
            ),
          ImageButtonWidget(
            AppImages.greenBoard,
            width: width.sp,
            activeColor: Colors.white,
            onTap: onTap,
            content: Positioned.fill(
              child: Center(
                child: FittedBox(
                  child: TextWidget(
                    text: textButtonEnum.getTextButton,
                  ).px(20).pOnly(bottom: 4).rotate(355),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
