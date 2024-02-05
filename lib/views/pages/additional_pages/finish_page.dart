import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/pages/home/home_page.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

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
                  width: Get.width * 0.5,
                  height: Get.height * 0.55,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: const Text(
                              'Luar Biasa!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppFonts.clapHand,
                                color: AppColors.primary500,
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: const Text(
                              'Kamu naik level',
                              style: TextStyle(
                                fontFamily: AppFonts.chubbyCrayon,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 85,
                bottom: 25,
                child: Image.asset(
                  AppImages.happyGirl,
                  height: Get.height * 0.70,
                ),
              ),
              Positioned(
                right: 65,
                bottom: 25,
                child: Image.asset(
                  AppImages.happyBoy,
                  height: Get.height * 0.65,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
