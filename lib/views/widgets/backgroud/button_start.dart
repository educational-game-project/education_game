import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/button/green_board_button.dart';
import 'package:flutter/material.dart';

class ButtonStart extends StatelessWidget {
  const ButtonStart({
    super.key,
    this.isHome = false,
    this.onTap,
  });
  final bool isHome;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isHome)
          Positioned(
            bottom: -50,
            right: 0,
            child: Image.asset(
              AppImages.lineDotRight,
              height: 160,
              width: 160,
            ),
          ),
        Positioned(
          right: 20,
          bottom: 0,
          child: GreenBoardButton(
            textButtonEnum:
                isHome ? TextButtonEnum.mulai : TextButtonEnum.lanjut,
            onTap: onTap,
            showWood: true,
          ),
        ),
      ],
    );
  }
}
