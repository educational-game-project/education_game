import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImageButtonWidget extends HookWidget {
  const ImageButtonWidget(
    this.image, {
    super.key,
    this.height,
    this.width,
    this.color,
    this.activeColor,
    this.onTap,
    this.content,
  });
  final String image;
  final double? height;
  final double? width;
  final Color? color;
  final Color? activeColor;
  final Function()? onTap;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    final isClicked = useState(false);
    void clicked(bool value) => isClicked.value = value;
    void onClicked() async {
      if (!isClicked.value) {
        debugPrint('clicked button');
        clicked(true);
        if (onTap != null) onTap!(); // On Tap
        await Future.delayed(const Duration(milliseconds: 10));
        clicked(false);
      }
    }

    Widget defaultContent() {
      return Image.network(
        image,
        height: height,
        width: width,
        color: isClicked.value ? activeColor : color,
      );
    }

    Widget buildContent() {
      if (content == null) return defaultContent();
      return Stack(
        children: [
          defaultContent(),
          content!,
        ],
      );
    }

    return GestureDetector(
      onTap: onClicked,
      child: buildContent(),
    );
  }
}
