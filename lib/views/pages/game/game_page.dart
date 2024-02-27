import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/enums/game/game_enum.dart';
import 'package:education_game/views/pages/game/berhitung/ayo_berhitung.dart';
import 'package:education_game/views/pages/game/gambar/tebak_gambar.dart';
import 'package:education_game/views/pages/game/kata/tebak_kata_widget.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:education_game/views/widgets/backgroud/background_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameController = Get.put(GameController())..timeStart();

    Widget game() {
      switch (gameController.gameEnum.value) {
        case GameEnum.ayoBerhitung:
          return const AyoBerhitungWidget();
        case GameEnum.tebakGambar:
          return const TebakGambarWidget();
        case GameEnum.tebakKata:
          return const TebakKataWidget();
      }
    }

    return Obx(() {
      return PopScope(
        onPopInvoked: (didPop) {
          gameController.reset();
        },
        child: BackgroudGameWidget(
          isLoading: gameController.isLoading.value,
          onTapHome: () {
            gameController.reset();
            Get.offAll(() => const HomePage());
          },
          // onTapHome: () => Get.to(const LeaderBoardPage()),
          onBack: () => Get.back(),
          onContinue: gameController.onCek,
          stars: gameController.liveLeft.value,
          title: 'Level ${gameController.selectedLevel.value}',
          showButton: gameController.gameEnum.value != GameEnum.ayoBerhitung,
          child: game(),
        ),
      );
    });
  }
}
