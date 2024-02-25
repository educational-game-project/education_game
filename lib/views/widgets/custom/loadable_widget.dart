import 'package:flutter/material.dart';

class LoadableWidget extends StatelessWidget {
  const LoadableWidget({
    super.key,
    required this.child,
    this.isLoading = false,
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black38,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
      ],
    );
  }
}
