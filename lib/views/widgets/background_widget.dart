import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/backgroud/button_exit.dart';
import 'package:education_game/views/widgets/backgroud/button_start.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:education_game/views/widgets/custom/loadable_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:velocity_x/velocity_x.dart';

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
    this.isLoading = false,
    this.title,
  });
  final Widget child;
  final Function()? onContinue;
  final Function()? onBack;
  final Function()? onStart;
  final Function()? onExit;
  final Function()? onTapHome;
  final bool isHome;
  final String? title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

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
            height: size.height * 0.13,
            activeColor: Colors.white,
            onTap: onTapHome,
          ).px(8.sp).pOnly(top: 12.sp, bottom: 4.sp),
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
      return Align(
        alignment: Alignment.topLeft,
        child: ImageButtonWidget(
          AppImages.tombolKembali,
          height: size.height * 0.15,
          activeColor: Colors.white,
          onTap: onBack,
        ),
      ).px(8.sp).pOnly(top: 12.sp, bottom: 4.sp);
    }

    Widget buildTitle() {
      return Align(
        alignment: Alignment.topCenter,
        child: TextWidget(
          text: title!,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ).px(8.sp).pOnly(top: 12.sp, bottom: 4.sp),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: LoadableWidget(
        isLoading: isLoading,
        child: Stack(
          children: [
            if (onTapHome != null) lineBottomLeft() else decorationBottomLeft(),
            if (onTapHome != null) ...home() else decorationTopRight(),
            if (title != null) buildTitle(),
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
        ),
      ),
    );
  }
}
