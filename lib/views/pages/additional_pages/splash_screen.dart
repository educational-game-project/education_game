import 'package:education_game/utils/fonts.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:education_game/utils/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(
        const Duration(seconds: 5),
        () {
          Get.to(() => const HomePage());
        },
      );
      return null;
    }, []);

    return Scaffold(
      // appBar: const GeneralAppbar(),
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Get.width * 0.7,
              height: Get.height * 0.7,
              alignment: AlignmentDirectional.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(),
                        StreamBuilder<int>(
                          initialData: 0,
                          stream: Stream.periodic(const Duration(seconds: 1),
                              (computationCount) => computationCount),
                          builder: (context, snapshot) {
                            var up = (snapshot.data ?? 0) % 2 == 0 ||
                                snapshot.data == 0;
                            return AnimatedPositioned(
                              duration: const Duration(seconds: 1),
                              bottom: up ? 10 : 0,
                              left: 0,
                              right: 0,
                              child: Image.network(
                                AppImages.logo,
                                height: Get.height * 0.35,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Kognitif Game',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.info400,
                      fontFamily: AppFonts.clapHand,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
