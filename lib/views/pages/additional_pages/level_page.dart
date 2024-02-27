import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/enums/game/game_enum.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/game/game_page.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:education_game/views/widgets/background_widget.dart';
import 'package:education_game/views/widgets/button/custom_button_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LevelPage extends HookWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController());
    var levels = [1, 2, 3];

    useEffect(() {
      Future.delayed(Duration.zero, () => gameController.getLevelGame());
      return null;
    }, [gameController]);

    Widget item({required int level, bool isActive = true}) {
      var isActive = level <= gameController.currentLevel.value;
      return Center(
        child: CustomButtonWidget(
          onTap: () {
            if (isActive) {
              gameController.setLevel(level);
              Get.to(() => const GamePage());
            }
          },
          color: isActive
              ? GameEnum.values[(level - 1) % 3].getColor
              : AppColors.grey,
          borderRadius: BorderRadius.circular(50.sp),
          child: Container(
            padding: EdgeInsets.all(8.sp),
            height: Get.width * 0.22,
            width: Get.width * 0.22,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'Level',
                      fontSize: 10.sp,
                      fontsEnum: FontsEnum.clapHand,
                    ),
                    TextWidget(
                      text: level.toString(),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      fontsEnum: FontsEnum.clapHand,
                    ).py(4.sp),
                  ],
                ),
                if (!isActive)
                  Positioned.fill(child: Image.network(AppImages.lock)),
              ],
            ),
          ),
        ).px(4.sp).pOnly(top: 20.sp),
      );
    }

    return Obx(() {
      return BackgroudWidget(
        isLoading: gameController.isLoading.value,
        onTapHome: () => Get.offAll(const HomePage()),
        onBack: () => Get.back(),
        title: gameController.gameEnum.value.getTitle,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: levels.map((e) => item(level: e)).toList(),
          ).centered(),
        ).px(Get.width * 0.1).py(Get.height * 0.1),
      );
    });
  }
}
