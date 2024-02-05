import 'package:education_game/utils/fonts.dart';
import 'package:education_game/views/pages/additional_pages/playground_page.dart';
import 'package:education_game/views/widgets/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ChooseGame extends StatelessWidget {
  const ChooseGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChooseGame();
  }
}

class _ChooseGame extends StatelessWidget {
  const _ChooseGame();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackgroudWidget(
      onBack: () => Get.back(),
      // title: 'Pilih Permainan',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Get.to(const PlaygroundPage());
              },
              child: Container(
                height: Get.height * 0.38,
                width: Get.width * 0.18,
                decoration: BoxDecoration(
                  color: const Color(0xff2FABE0),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: const Offset(2, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: const Column(
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
                Get.to(const PlaygroundPage());
              },
              child: Container(
                height: Get.height * 0.38,
                width: Get.width * 0.18,
                decoration: BoxDecoration(
                  color: const Color(0xffB764C1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: const Offset(2, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: const Column(
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
              Get.to(const PlaygroundPage());
            },
            child: Container(
              height: Get.height * 0.38,
              width: Get.width * 0.18,
              decoration: BoxDecoration(
                color: const Color(0xff4AB448),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.20),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(2, 4), // changes position of shadow
                  ),
                ],
              ),
              child: const Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
