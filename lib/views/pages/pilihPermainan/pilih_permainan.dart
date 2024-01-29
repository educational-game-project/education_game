import 'package:education_game/cubit/Api/api_cubit.dart';
import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/enums/api/auth_status_enum.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/login/login_page.dart';
import 'package:education_game/views/pages/playground_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class PilihPermainan extends StatelessWidget {
  const PilihPermainan({super.key});

  @override
  Widget build(BuildContext context) {
    return _PilihPermainan();
  }
}

class _PilihPermainan extends StatelessWidget {
  const _PilihPermainan({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.kiriBawah,
              height: size.height * 0.30,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              AppImages.kananAtas,
              height: size.height * 0.35,
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(PlaygroundPage());
                      },
                      child: Container(
                        height: Get.height * 0.38,
                        width: Get.width * 0.18,
                        decoration: BoxDecoration(
                          color: Color(0xff2FABE0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ayo \nBerhitung",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppFonts.clapHand),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(PlaygroundPage());
                      },
                      child: Container(
                        height: Get.height * 0.38,
                        width: Get.width * 0.18,
                        decoration: BoxDecoration(
                          color: Color(0xffB764C1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tebak \nGambar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppFonts.clapHand),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(PlaygroundPage());
                      },
                      child: Container(
                        height: Get.height * 0.38,
                        width: Get.width * 0.18,
                        decoration: BoxDecoration(
                          color: Color(0xff4AB448),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tebak \nKata",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppFonts.clapHand),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )),
                ],
              )),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // tombol keluar
                  GestureDetector(
                    child: Image.asset(
                      AppImages.tombolKembali,
                      height: size.height * 0.19,
                    ),
                  ),
                  Image.asset(
                    AppImages.kiriAtas,
                    height: size.height * 0.15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
