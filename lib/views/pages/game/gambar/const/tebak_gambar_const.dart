import 'package:education_game/utils/audio.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/game/gambar/model/tebak_gambar.dart';

class TebakGambarConst {
  TebakGambarConst._();
  static const level1 = TebakGambar(
    level: 1,
    audio: AppAudios.semangka,
    answers: [
      AppImages.apel,
      AppImages.nanas,
      AppImages.mangga,
      AppImages.alpukat,
      // AppImages.lemon,
      AppImages.jeruk,
      AppImages.semangka,
    ],
    answerKey: AppImages.semangka,
  );
  static const level2 = TebakGambar(
    level: 2,
    audio: AppAudios.kucing,
    answers: [
      AppImages.kelinci,
      AppImages.ayam,
      AppImages.gajah,
      AppImages.singa,
      AppImages.kucing,
      AppImages.anjing,
    ],
    answerKey: AppImages.kucing,
  );
  static const level3 = TebakGambar(
    level: 3,
    audio: AppAudios.ayam,
    answers: [
      AppImages.kelinci,
      AppImages.ayam,
      AppImages.gajah,
      AppImages.singa,
      AppImages.kucing,
      AppImages.anjing,
    ],
    answerKey: AppImages.ayam,
  );

  static TebakGambar level(int level) {
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
