import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:flutter/material.dart';

class ButtonExit extends StatelessWidget {
  const ButtonExit({
    super.key,
    this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 120,
          child: Image.network(
            AppImages.kiriAtas,
            height: size.height * 0.15,
          ),
        ),
        Positioned(
          top: 0,
          left: 20,
          child: Image.network(
            AppImages.lineWood,
            height: 50,
            width: 50,
          ),
        ),
        Positioned(
          top: 0,
          left: 80,
          child: Image.network(
            AppImages.lineWood,
            height: 50,
            width: 50,
          ),
        ),
        Positioned(
          top: 0,
          left: 20,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ImageButtonWidget(
              AppImages.iconExit,
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
