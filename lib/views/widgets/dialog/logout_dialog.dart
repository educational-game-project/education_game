import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<dynamic> logoutDialog() {
  // context.read<AuthCubit>().logout();
  return Get.dialog(
    Center(
      child: SizedBox(
        width: Get.width * 0.65,
        height: Get.height * 0.7,
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primary100,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(AppImages.think),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Yakin mau keluar?",
                            style: TextStyle(
                              fontFamily: AppFonts.chubbyCrayon,
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(AppImages.batang),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ImageButtonWidget(
                                    AppImages.noGreen,
                                    activeColor: Colors.white,
                                    onTap: () => Get.back(),
                                  ),
                                  ImageButtonWidget(
                                    AppImages.yesRed,
                                    activeColor: Colors.white,
                                    onTap: () => Get.back(result: true),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
