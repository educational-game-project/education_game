import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
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
          right: 40,
          bottom: 0,
          child: Image.asset(
            AppImages.lineWood,
            height: 80,
            width: 80,
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ImageButtonWidget(
              isHome ? AppImages.iconStart : AppImages.iconContinue,
              width: 120,
              activeColor: Colors.white,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
