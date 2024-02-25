import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/widgets/button/custom_button_widget.dart';
import 'package:education_game/views/widgets/drag_and_drop/draggable_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class TebakKataWidget extends StatelessWidget {
  const TebakKataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var word = 'Se_ola_';
    var answerKey = 'akmlh';
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

    Widget dragTarget(String charTarget) {
      return DragTarget<String>(
        onAcceptWithDetails: (details) {
          // gameController.onDragged(details.data);
          // debugPrint('dragged : ${details.data}');
          // debugPrint('dragged : ${gameController.totalDragged}');
        },
        builder: (context, candidateData, rejectedData) {
          return charItem(
            '...',
            color: AppColors.backgroundGameTop,
            isDragTarget: true,
          );
          // return Container();
        },
      );
    }

    Widget words(String word) {
      var listChar = word.split('');
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listChar.map((e) {
          if (e == '_') return dragTarget(e).px(2.sp);
          return charItem(e).px(2.sp);
        }).toList(),
      );
    }

    Widget itemDraggable(String char) {
      return CustomButtonWidget(onTap: () {}, child: TextWidget(text: char));
    }

    Widget draggable(String char) {
      return DraggableWidget(
        data: answerKey.indexOf(char),
        feedback: charItem(char, color: AppColors.blue),
        childWhenDragging: charItem(char, color: AppColors.grey),
        child: charItem(char, color: AppColors.blue),
      );
    }

    Widget answer(String word) {
      var listChar = word.split('');
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: listChar.map((e) {
          return draggable(e).px(2.sp);
        }).toList(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        words(word).py(12.sp),
        HStack([
          TextWidget(
            text: 'Jawab :',
            color: Colors.black,
            fontSize: 14.sp,
          ),
          answer(answerKey),
        ]),
      ],
    );
  }
}
