import 'package:dotted_border/dotted_border.dart';
import 'package:education_game/controller/game_controller.dart';
import 'package:education_game/utils/colors.dart';
import 'package:education_game/views/widgets/button/custom_button_widget.dart';
import 'package:education_game/views/widgets/drag_and_drop/draggable_widget.dart';
import 'package:education_game/views/widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AyoBerhitungWidget extends StatelessWidget {
  const AyoBerhitungWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var gameController = Get.put(GameController());
    var number1 = gameController.ayoBerhitung.number1;
    var number2 = gameController.ayoBerhitung.number2;

    Widget image({Color? color}) {
      return Image.network(
        gameController.ayoBerhitung.image,
        height: 26.sp,
        width: 26.sp,
        color: color,
      );
    }

    Widget item(Alignment alignment) {
      return Align(
        alignment: alignment,
        child: DraggableWidget(
          data: 1,
          feedback: image(),
          childWhenDragging: image(color: Colors.grey),
          child: image(),
        ),
      );
    }

    Widget row(List<Widget> list) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      );
    }

    Widget column(List<Widget> list) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      );
    }

    Widget formatter(num x) {
      var showTopLeft = [2, 3, 4, 5].contains(x);
      var showTopRight = [3, 4, 5].contains(x);
      var showCenter = [1, 2, 3, 5].contains(x);
      var showBottomLeft = [4, 5].contains(x);
      var showBottomRight = [4, 5].contains(x);
      return column([
        row([
          (showTopLeft) ? item(Alignment.topLeft) : const Spacer(),
          (showTopRight) ? item(Alignment.topRight) : const Spacer(),
        ]),
        if (showCenter) item(Alignment.center),
        row([
          (showBottomLeft) ? item(Alignment.bottomLeft) : const Spacer(),
          (showBottomRight) ? item(Alignment.bottomRight) : const Spacer(),
        ]),
      ]).h(84.sp).w(70.sp);
    }

    Widget resultFormatter(num x) {
      return Wrap(
        alignment: WrapAlignment.spaceAround,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceAround,
        spacing: 4.sp,
        children: List.filled(x.toInt(), image()),
      ).w(double.infinity).h(double.infinity);
    }

    Widget leftSide() => formatter(number1);
    Widget rightSide() => formatter(number2);
    Widget result() {
      return DragTarget<int>(
        onAcceptWithDetails: (details) {
          gameController.onDragged(details.data);
        },
        builder: (context, candidateData, rejectedData) {
          return DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(12.sp),
            dashPattern: [10.sp, 6.sp],
            strokeWidth: 2.sp,
            child:
                resultFormatter(gameController.totalDraggedAyoBerhitung.value)
                    .p(4.sp),
          ).w(100.sp).h(90.sp);
        },
      );
    }

    Widget answer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(
            text: 'Jawab : ',
            color: Colors.black,
          ),
          ...gameController.ayoBerhitung.answers.map((value) {
            return CustomButtonWidget(
              onTap: () {
                debugPrint('clicked $value');
                if (gameController.isDraggedAll) {
                  gameController.onAnswer(value);
                }
              },
              borderRadius: BorderRadius.circular(4.sp),
              color: AppColors.blue,
              child: TextWidget(
                text: value.toString(),
                fontSize: 8.sp,
                fontsEnum: FontsEnum.clapHand,
              ).px(4.sp).py(2.sp),
            ).opacity(value: gameController.isDraggedAll ? 1 : 0.5).px(2.sp);
          }),
        ],
      ).pOnly(bottom: 8.sp, right: 20.sp);
    }

    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leftSide(),
                  Icon(Icons.add_rounded, size: 30.sp),
                  rightSide(),
                  Icon(Icons.drag_handle_rounded, size: 30.sp)
                      .pOnly(right: 8.sp),
                  result(),
                ],
              ).py(12.sp),
              answer(),
            ],
          ).fittedBox(),
        ],
      );
    });
  }
}
