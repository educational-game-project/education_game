import 'package:education_game/views/pages/game/kata/model/tebak_kata.dart';

class TebakKataConst {
  TebakKataConst._();
  static const level1 = TebakKata(
    level: 1,
    word: ['S', 'e', 'p', '_', 't', 'u'],
    answer: ['a', 'l', 'f', 'p', 't'],
    answerKey: 'Sepatu',
  );
  static const level2 = TebakKata(
    level: 2,
    word: ['S', 'e', '_', 'o', 'l', 'a', '_'],
    answer: ['k', 's', 'o', 'h'],
    answerKey: 'Sekolah',
  );
  static const level3 = TebakKata(
    level: 3,
    word: ['L', 'u', '_', 'i', 's', 'a', '_'],
    answer: ['a', 'l', 'n', 'k', 'm', 'd'],
    answerKey: 'Lukisan',
  );

  static TebakKata level(int level) {
    switch (level) {
      case 1:
        return level1;
      case 2:
        return level2;
      case 3:
        return level3;
      default:
        return level1;
    }
  }
}
