import 'package:education_game/views/widgets/button/green_board_button.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Get.width * 0.65,
        height: Get.height * 0.7,
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primary100,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: TextWidget(
                          text: 'Kamu\nHebat!',
                          fontsEnum: FontsEnum.clapHand,
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ).py(16.h),
                      Expanded(child: Container())
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GreenBoardButton(
                  textButtonEnum: TextButtonEnum.selanjutnya,
                  onTap: () => Get.back(result: true),
                  showWood: true,
                ),
              ),
              Positioned(
                left: 40,
                bottom: 0,
                child: Image.asset(
                  AppImages.happyGirl,
                  height: Get.height * 0.50,
                ),
              ),
              Positioned(
                right: 40,
                bottom: 0,
                child: Image.asset(
                  AppImages.happyBoy,
                  height: Get.height * 0.50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
