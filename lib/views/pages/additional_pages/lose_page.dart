import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:education_game/views/widgets/button/green_board_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LosePage extends StatelessWidget {
  const LosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.to(const HomePage()),
                child: Image.asset(
                  AppImages.home,
                  height: Get.height * 0.155,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: Get.width * 0.45,
                  height: Get.height * 0.65,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(30),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          'Bintang kamu habis!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppFonts.clapHand,
                            color: AppColors.primary500,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          'Ayo main lagi',
                          style: TextStyle(
                            fontFamily: AppFonts.chubbyCrayon,
                            fontSize: 28,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GreenBoardButton(
                  onTap: () => Get.back(result: true),
                  textButtonEnum: TextButtonEnum.mainLagi,
                  showWood: true,
                ),
              ),
              Positioned(
                left: 85,
                bottom: 50,
                child: Image.asset(
                  AppImages.sad,
                  // width: Get.width * 0.5,
                  height: Get.height * 0.65,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
