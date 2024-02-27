import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/widgets/drag_and_drop/draggable_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class TebakKataWidget extends HookWidget {
  const TebakKataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var gameController = Get.put(GameController());

    useEffect(() {
      Future.delayed(Duration.zero, () => gameController.initTebakKata());
      return null;
    }, [gameController]);

    Widget charItem(String char, {Color? color, bool isDragTarget = false}) {
      return Container(
        decoration: BoxDecoration(
            color: color ?? AppColors.primary500,
            borderRadius: BorderRadius.circular(8.sp),
            border: isDragTarget
                ? Border.all(color: AppColors.primary500, width: 2.sp)
                : null,
            boxShadow: [
              BoxShadow(
                offset: Offset(0.5.sp, 1.sp),
                blurRadius: 1.sp,
                spreadRadius: 1.sp,
                color: AppColors.grey,
              )
            ]),
        child: SizedBox(
          height: 24.sp,
          width: 24.sp,
          child: TextWidget(
            text: char,
            color: color == AppColors.blue ? null : Colors.black,
            fontsEnum: FontsEnum.clapHand,
          ).fittedBox().centered(),
        ),
      );
    }

    Widget dragTarget(int index) {
      return DragTarget<int>(
        onAcceptWithDetails: (details) {
          gameController.onDraggedTebakKata(details.data, index);
        },
        builder: (context, candidateData, rejectedData) {
          var newValue = gameController.wordTebakKata.value[index];
          return charItem(
            newValue != '_' ? newValue : '...',
            color: AppColors.backgroundGameTop,
            isDragTarget: true,
          );
          // return Container();
        },
      );
    }

    Widget words() {
      var listChar = gameController.tebakKata.word;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listChar.mapIndexed((e, index) {
          if (e == '_') return dragTarget(index).px(2.sp);
          return charItem(e).px(2.sp);
        }).toList(),
      );
    }

    Widget draggable(String char) {
      var word = gameController.tebakKata.word;
      var wordAnswered = gameController.wordTebakKata.value;
      var indexs = List<int>.empty(growable: true);
      for (var i = 0; i < word.length; i++) {
        if (word[i] != wordAnswered[i]) indexs.add(i);
      }
      var isDragged = indexs.any((e) => char == wordAnswered[e]);
      if (isDragged) return SizedBox(height: 24.sp, width: 24.sp);
      return DraggableWidget(
        data: gameController.answerTebakKata.value.indexOf(char),
        keepWidget: true,
        feedback: charItem(char, color: AppColors.blue),
        childWhenDragging: charItem(char, color: AppColors.grey),
        child: charItem(char, color: AppColors.blue),
      );
    }

    Widget answer() {
      var listChar = gameController.answerTebakKata.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listChar.map((e) {
          return draggable(e).px(2.sp);
        }).toList(),
      );
    }

    return Obx(() {
      if (gameController.wordTebakKata.value.isEmpty) return Container();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          words().py(12.sp),
          HStack([
            TextWidget(
              text: 'Jawab :',
              color: Colors.black,
              fontSize: 14.sp,
            ),
            answer(),
          ]),
        ],
      );
    });
  }
}
