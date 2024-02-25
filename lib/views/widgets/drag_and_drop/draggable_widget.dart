import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DraggableWidget extends HookWidget {
  const DraggableWidget({
    super.key,
    required this.data,
    required this.feedback,
    this.childWhenDragging,
    required this.child,
  });
  final int data;
  final Widget feedback;
  final Widget? childWhenDragging;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDragged = useState(false);
    return Stack(
      children: [
        Draggable<int>(
          onDragCompleted: () {
            isDragged.value = true;
          },
          onDragEnd: (details) {},
          data: data,
          childWhenDragging: childWhenDragging,
          feedback: feedback,
          child: child,
        ),
        if (isDragged.value)
          Positioned.fill(child: Container(color: Colors.white))
      ],
    );
  }
}
