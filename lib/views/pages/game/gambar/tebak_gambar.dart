import 'package:audioplayers/audioplayers.dart';
import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TebakGambarWidget extends HookWidget {
  const TebakGambarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController())..initTebakGambar();

    // useEffect(() {
    //   Future.delayed(Duration.zero, () => gameController.initTebakGambar());
    //   return null;
    // }, [gameController]);

    Widget image(
      String image, {
      double? size,
    }) {
      var isSelected = gameController.answerTebakGambar.value == image;
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.backgroundGameTop : null,
        ),
        child: ImageButtonWidget(
          image,
          height: size ?? 30.sp + (isSelected ? 4.sp : 0),
          width: size ?? 30.sp + (isSelected ? 4.sp : 0),
          activeColor: Colors.white,
          onTap: () {
            gameController.onAnswerTebakGambar(image);
          },
        ).p(2.sp),
      );
    }

    Widget format(List<String> list) {
      var listAlign = [
        // Alignment.topCenter,
        Alignment.topLeft,
        Alignment.centerLeft,
        Alignment.bottomLeft,
        Alignment.bottomRight,
        Alignment.centerRight,
        Alignment.topRight,
      ];
      Widget item(Alignment alignment, int index) {
        if (list.length < index) return Container();
        var isTopCorner =
            [Alignment.topLeft, Alignment.topRight].contains(alignment);
        var isBottomCorner =
            [Alignment.bottomLeft, Alignment.bottomRight].contains(alignment);
        return Padding(
          padding: isTopCorner
              ? EdgeInsets.symmetric(horizontal: 26.sp, vertical: 4.sp)
              : isBottomCorner
                  ? EdgeInsets.symmetric(horizontal: 26.sp, vertical: 4.sp)
                  : EdgeInsets.zero,
          child: Align(alignment: alignment, child: image(list[index])),
        );
      }

      return AspectRatio(
        aspectRatio: 8 / 7,
        child: Stack(
          children: [
            ...listAlign.mapIndexed((currentValue, index) {
              return item(listAlign[index], index);
            }),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => gameController.audioPlayPause(),
                borderRadius: BorderRadius.circular(100.sp),
                child: CircleAvatar(
                  backgroundColor: AppColors.primary500,
                  radius: 14.sp,
                  child: Icon(
                    gameController.audioState.value == PlayerState.playing
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 24.sp,
                    color: Colors.red,
                  ).centered(),
                ),
              ),
            ),
          ],
        ),
      ).py(8.sp);
    }

    return Obx(() {
      return PopScope(
        onPopInvoked: (didPop) {
          Future.delayed(Duration.zero, gameController.reset);
        },
        child: format(gameController.tebakGambar.answers),
      );
    });
  }
}
