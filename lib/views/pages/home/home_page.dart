import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/pages/playground_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(
          //       vertical: 16,
          //     ),
          //     height: 225,
          //     width: MediaQuery.of(context).size.width / 2,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(80),
          //     ),
          //     child: const Column(
          //       children: [
          //         Expanded(
          //           flex: 3,
          //           child: FittedBox(
          //             fit: BoxFit.fill,
          //             child: Text(
          //               'Permainan',
          //               style: TextStyle(
          //                 fontFamily: AppFonts.chubbyCrayon,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           flex: 4,
          //           child: FittedBox(
          //             fit: BoxFit.fill,
          //             child: Text(
          //               'Kognitif',
          //               style: TextStyle(
          //                 color: AppColors.info500,
          //                 fontFamily: AppFonts.chubbyCrayon,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // tombol keluar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlaygroundPage(),
                          ));
                    },
                    child: Image.asset(
                      "assets/icons/tombol_keluar.png",
                      height: MediaQuery.of(context).size.height * 0.19,
                    ),
                  ),
                  Image.asset(
                    "assets/icons/kiri_atas.png",
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/icons/kanan_atas.png",
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/icons/center.png",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/icons/kiri_bawah.png",
              height: MediaQuery.of(context).size.height * 0.30,
            ),
          ),

          // tombol mulai
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlaygroundPage(),
                    ));
              },
              child: Image.asset(
                "assets/icons/kanan_bawah.png",
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
