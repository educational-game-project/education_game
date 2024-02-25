import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/button/green_board_button.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:education_game/views/widgets/custom/loadable_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:velocity_x/velocity_x.dart';

class BackgroudGameWidget extends StatelessWidget {
  const BackgroudGameWidget({
    super.key,
    required this.child,
    this.onContinue,
    this.onBack,
    this.onTapHome,
    required this.stars,
    this.title,
    this.showButton = true,
    this.isLoading = false,
  });
  final Widget child;
  final Function()? onContinue;
  final Function()? onBack;
  final Function()? onTapHome;
  final int stars;
  final String? title;
  final bool showButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    Widget home() {
      return ImageButtonWidget(
        AppImages.iconHome,
        height: size.height * 0.13,
        activeColor: Colors.white,
        onTap: onTapHome,
      );
    }

    Widget backButton() {
      return ImageButtonWidget(
        AppImages.tombolKembali,
        height: size.height * 0.13,
        activeColor: Colors.white,
        onTap: onBack,
      );
    }

    Widget tiitle() {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primary500,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: TextWidget(
          text: title!,
          fontSize: 8.sp,
          color: Colors.black,
          fontsEnum: FontsEnum.clapHand,
        ).px(8.sp).py(4.sp),
      );
    }

    Widget star() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [1, 2, 3].map((e) {
          return Image.asset(
            AppImages.rateStar,
            height: 14.sp,
            width: 16.sp,
            color: e <= stars ? null : Colors.grey,
          ).px(2.sp);
        }).toList(),
      );
    }

    Widget topWidget() {
      var radius = Radius.circular(8.sp);
      return Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundGameTop,
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onBack != null) backButton(),
            const Spacer(),
            if (title != null) tiitle(),
            star().expand(),
            if (onTapHome != null) home(),
          ],
        ).px(8.sp).pOnly(top: 12.sp, bottom: 4.sp),
      );
    }

    Widget cekButton() {
      if (!showButton) return Container();
      return Align(
        alignment: Alignment.bottomRight,
        child: GreenBoardButton(
          textButtonEnum: TextButtonEnum.cek,
          onTap: onContinue,
          showWood: true,
        ),
      ).px(8.sp);
    }

    return Scaffold(
      body: LoadableWidget(
        isLoading: isLoading,
        child: Column(
          children: [
            topWidget(),
            Stack(
              children: [
                Align(alignment: Alignment.center, child: child),
                cekButton(),
              ],
            ).expand(),
          ],
        ).h(double.infinity).w(double.infinity),
      ),
    );
  }
}
