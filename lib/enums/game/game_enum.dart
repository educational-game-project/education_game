import 'package:education_game/utils/colors.dart';
import 'package:flutter/material.dart';

enum GameEnum {
  ayoBerhitung,
  tebakGambar,
  tebakKata;

  String get getTitle {
    switch (this) {
      case ayoBerhitung:
        return 'Ayo Berhitung';
      case tebakGambar:
        return 'Tebak Gambar';
      case tebakKata:
        return 'Tebak Kata';
      default:
        return '';
    }
  }

  Color get getColor {
    switch (this) {
      case ayoBerhitung:
        return AppColors.blue;
      case tebakGambar:
        return AppColors.purple;
      case tebakKata:
        return AppColors.green;
      default:
        return AppColors.blue;
    }
  }
}

extension ConvertGameEnum on String {
  GameEnum? get toGameEnum {
    switch (this) {
      case 'Ayo Berhitung':
        return GameEnum.ayoBerhitung;
      case 'Tebak Gambar':
        return GameEnum.tebakGambar;
      case 'Tebak Kata':
        return GameEnum.tebakKata;
      default:
        return null;
    }
  }
}
