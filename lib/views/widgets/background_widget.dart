import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/backgroud/button_exit.dart';
import 'package:education_game/views/widgets/backgroud/button_start.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:flutter/material.dart';

class BackgroudWidget extends StatelessWidget {
  const BackgroudWidget({
    super.key,
    required this.child,
    this.onContinue,
    this.onBack,
    this.onStart,
    this.onExit,
    this.onTapHome,
    this.isHome = false,
  });
  final Widget child;
  final Function()? onContinue;
  final Function()? onBack;
  final Function()? onStart;
  final Function()? onExit;
  final Function()? onTapHome;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<Widget> home() {
      return [
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            AppImages.lineDotTopRight,
            height: size.height * 0.43,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ImageButtonWidget(
            AppImages.iconHome,
            height: size.height * 0.35,
            activeColor: Colors.white,
            onTap: onTapHome,
          ),
        ),
      ];
    }

    Widget decorationTopRight() {
      return Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          AppImages.kananAtas,
          height: size.height * 0.35,
        ),
      );
    }

    Widget decorationBottomLeft() {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Image.asset(
          AppImages.kiriBawah,
          height: size.height * 0.35,
        ),
      );
    }

    Widget lineBottomLeft() {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Image.asset(
          AppImages.lineDotBottomLeft,
          height: size.height * 0.43,
        ),
      );
    }

    Widget backButton() {
      return Positioned(
        left: 20,
        top: 30,
        child: ImageButtonWidget(
          AppImages.tombolKembali,
          activeColor: Colors.white,
          onTap: onBack,
        ),
      );
    }

    return Stack(
      children: [
        if (onTapHome != null) lineBottomLeft() else decorationBottomLeft(),
        if (onTapHome != null) ...home() else decorationTopRight(),
        Align(
          alignment: Alignment.center,
          child: child,
        ),
        if (onBack != null) backButton(),
        if (onExit != null) ButtonExit(onTap: onExit),
        if ((onStart ?? onContinue) != null)
          ButtonStart(
            isHome: onStart != null,
            onTap: onStart ?? onContinue,
          ),
      ],
    );
  }
}
