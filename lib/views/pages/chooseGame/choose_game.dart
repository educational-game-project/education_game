import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/enums/game/game_enum.dart';
import 'package:education_game/views/pages/additional_pages/level_page.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:education_game/views/widgets/background_widget.dart';
import 'package:education_game/views/widgets/button/custom_button_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseGame extends HookWidget {
  const ChooseGame({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController());
    useEffect(() {
      Future.delayed(Duration.zero, () => gameController.getListGame());
      return null;
    }, [gameController]);

    Widget item(GameEnum? gameEnum) {
      if (gameEnum == null) return Container();
      return SizedBox(
        height: 70.sp,
        width: 80.sp,
        child: CustomButtonWidget(
          color: gameEnum.getColor,
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            gameController.setGameEnum(gameEnum);
            Get.to(() => const LevelPage());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: gameEnum.getTitle.replaceAll(' ', '\n'),
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                fontsEnum: FontsEnum.clapHand,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ).px(4.sp),
      );
    }

    return Obx(() {
      return BackgroudWidget(
        isLoading: gameController.isLoading.value,
        onBack: () => Get.to(const HomePage()),
        title: 'Pilih Permainan',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: gameController.listGame.value
              .map((e) => item(e.gameEnum))
              .toList(),
        ),
      );
    });
  }
}
