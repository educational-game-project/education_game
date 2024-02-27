import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/game/berhitung/model/ayo_berhitung.dart';

class AyoBerhitungConst {
  AyoBerhitungConst._();
  static const level1 = AyoBerhitung(
    level: 1,
    image: AppImages.elephant,
    number1: 3,
    number2: 2,
    answers: [2, 3, 5],
    answerKey: 5,
  );
  static const level2 = AyoBerhitung(
    level: 2,
    image: AppImages.apel,
    number1: 4,
    number2: 3,
    answers: [7, 5, 4],
    answerKey: 7,
  );
  static const level3 = AyoBerhitung(
    level: 3,
    image: AppImages.semangka,
    number1: 5,
    number2: 4,
    answers: [4, 8, 9],
    answerKey: 9,
  );

  static AyoBerhitung level(int level) {
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
