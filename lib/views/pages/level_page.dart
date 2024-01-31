import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/chooseGame/choose_game.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Get.to(const ChooseGame()),
                child: Image.asset(
                  AppImages.backArrow,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.vectorBottomLeft,
              height: Get.height * 0.4,
            ),
          )
        ],
      ),
    );
  }
}
