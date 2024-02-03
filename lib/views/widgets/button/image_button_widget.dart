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
  });
  final String image;
  final double? height;
  final double? width;
  final Color? color;
  final Color? activeColor;
  final Function()? onTap;

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

    return GestureDetector(
      onTap: onClicked,
      child: Image.asset(
        image,
        height: height,
        width: width,
        color: isClicked.value ? activeColor : color,
      ),
    );
  }
}
