import 'package:dotted_border/dotted_border.dart';
import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/models/leaderboard_model.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:education_game/views/widgets/background_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LeaderBoardPage extends HookWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController());

    useEffect(() {
      Future.delayed(Duration.zero, () => gameController.getLeaderBoardGame());
      return null;
    }, [gameController]);

    BoxDecoration imageBox(String url) {
      return BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      );
    }

    Widget itemMain(LeaderboardModel leaderboard, int ranked) {
      return VStack(
        [
          Container().expand(),
          Container(
            height: 30.sp,
            width: 30.sp,
            decoration: imageBox(leaderboard.user?.image?.fileLink ?? ''),
          ),
          TextWidget(
            text: leaderboard.user?.name ?? '',
            fontsEnum: FontsEnum.clapHand,
            fontSize: 8.sp,
          ).py(8.h),
          Container(
            height: (160 - (30 * ranked)).h,
            width: 50.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sp),
                topRight: Radius.circular(8.sp),
              ),
              border: Border.all(width: 1.sp),
            ),
            alignment: Alignment.topCenter,
            child: TextWidget(
              text: '$ranked',
              fontsEnum: FontsEnum.clapHand,
              color: AppColors.primary500,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ).pOnly(top: 8.sp),
          ),
        ],
        alignment: MainAxisAlignment.end,
        crossAlignment: CrossAxisAlignment.center,
      ).px(2.sp).expand();
    }

    Widget itemSeconds(LeaderboardModel leaderboard, int ranked) {
      return Container(
        alignment: Alignment.topLeft,
        child: Container(
          width: Get.width * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.sp),
            border: Border.all(width: 1.sp),
          ),
          child: HStack([
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 12.sp,
                  width: 12.sp,
                  decoration: imageBox(leaderboard.user?.image?.fileLink ?? ''),
                ).px(4.sp).pOnly(left: 4.sp),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: TextWidget(
                    text: '${ranked + 3}',
                    color: AppColors.primary500,
                    fontsEnum: FontsEnum.clapHand,
                    fontSize: 6.sp,
                  ).p(2.sp),
                ).px(4.sp),
              ],
            ),
            TextWidget(
              text: leaderboard.user?.name ?? '-',
              color: Colors.black,
              fontsEnum: FontsEnum.clapHand,
              fontSize: 6.sp,
            ).p(4.sp), //.expand(),
          ]),
        ).py(2.sp).px(8.sp),
      );
    }

    return Obx(() {
      var user = gameController.leaderboards.value.isEmpty
          ? null
          : gameController.leaderboards.value[0];
      var generated = user == null ? [] : List.filled(20, user);
      var listRanked = generated;
      var listRanded2 = generated;
      // var listRanked = gameController.leaderboards.value;
      // var listRanded2 = gameController.listRanked3Up;
      // var listRanked = [2, 1, 3];
      // var listRanded2 = [4, 5, 6, 7, 8];
      return BackgroudWidget(
        onTapHome: () => Get.offAll(() => const HomePage()),
        onContinue: () => Get.back(), //gameController.restartGame(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.sp),
                    color: Colors.green,
                  ),
                  child: TextWidget(
                    text: 'Papan Peringkat',
                    color: Colors.black,
                    fontsEnum: FontsEnum.clapHand,
                    fontSize: 14.sp,
                  ).centered().py(4.sp),
                ).w(Get.width * 0.7),
                Positioned.fill(
                  child: DottedBorder(
                    padding: EdgeInsets.zero,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12.sp),
                    dashPattern: [10.sp, 6.sp],
                    strokeWidth: 2.sp,
                    child: Container(),
                  ).p(1.sp),
                ),
              ],
            ),
            HStack([
              if (listRanked.isNotEmpty)
                HStack([
                  if (listRanked.length > 1) itemMain(listRanked[1], 2),
                  itemMain(listRanked[0], 1),
                  if (listRanked.length > 2) itemMain(listRanked[2], 3),
                ]).expand(),
              if (listRanded2.isNotEmpty)
                ListView(
                  children: listRanded2.mapIndexed((e, index) {
                    return itemSeconds(e, index + 1);
                  }).toList(),
                ).expand(),
            ]).expand()
          ],
        ).px(Get.width * 0.1).pOnly(top: Get.height * 0.1),
      );
    });
  }
}
