import 'package:audioplayers/audioplayers.dart';
import 'package:education_game/utils/audio.dart';
import 'package:education_game/utils/images.dart';
import 'package:education_game/views/pages/game/gambar/const/tebak_gambar_const.dart';
import 'package:education_game/views/widgets/button/image_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class TebakGambarWidget extends StatelessWidget {
  const TebakGambarWidget({super.key});

  Widget image(String image, {double? size, Function()? onTap}) {
    return ImageButtonWidget(
      image,
      height: size ?? 30.sp,
      width: size ?? 30.sp,
      activeColor: Colors.white,
      onTap: onTap ?? () {},
    );
  }

  Widget format(List<String> list) {
    var listAlign = [
      // Alignment.topCenter,
      Alignment.topLeft,
      Alignment.centerLeft,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.centerRight,
      Alignment.topRight,
    ];
    Widget item(Alignment alignment, int index) {
      if (list.length < index) return Container();
      var isTopCorner =
          [Alignment.topLeft, Alignment.topRight].contains(alignment);
      var isBottomCorner =
          [Alignment.bottomLeft, Alignment.bottomRight].contains(alignment);
      return Padding(
        padding: isTopCorner
            ? EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp)
            : isBottomCorner
                ? EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp)
                : EdgeInsets.zero,
        child: Align(alignment: alignment, child: image(list[index])),
      );
    }

    return AspectRatio(
      aspectRatio: 8 / 7,
      child: Stack(
        children: [
          ...listAlign.mapIndexed((currentValue, index) {
            return item(listAlign[index], index);
          }),
          // item(Alignment.topCenter, 0),
          // item(Alignment.topLeft, 1),
          // item(Alignment.centerLeft, 2),
          // item(Alignment.bottomLeft, 3),
          // item(Alignment.bottomRight, 4),
          // item(Alignment.centerRight, 5),
          // item(Alignment.topRight, 6),
          // item(Alignment.center, 7),
          Align(
            alignment: Alignment.center,
            child: image(
              AppImages.playAudio,
              onTap: () {
                var player = AudioPlayer();
                player.play(AssetSource(AppAudios.kucing));
              },
            ),
          ),
        ],
      ),
    ).py(8.sp);
  }

  @override
  Widget build(BuildContext context) {
    // var list = List.generate(10, (index) => AppImages.nanas);
    var list = TebakGambarConst.level2.answers;
    return format(list);
  }
}
