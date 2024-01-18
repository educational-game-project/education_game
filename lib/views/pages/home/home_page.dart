import 'package:education_game/utils/colors.dart';
import 'package:education_game/utils/fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFDB82B,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 225,
              width: 392,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80),
              ),
              child: Text(
                'hehe',
                style: TextStyle(
                  fontFamily: AppFonts.chubbyCrayon,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
