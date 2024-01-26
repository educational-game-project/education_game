import 'package:flutter/material.dart';

class GeneralAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppbar({super.key, this.backgroundColor, this.title});

  final Color? backgroundColor;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      title: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          if (title != null) title!,
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
