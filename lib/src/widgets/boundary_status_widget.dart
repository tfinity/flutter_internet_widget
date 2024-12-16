import 'package:flutter/material.dart';
import 'package:internet_widget/src/controller/internet_controller.dart';

class BoundaryStatusWidget extends StatefulWidget {
  const BoundaryStatusWidget({
    super.key,
    required this.child,
    required this.useSafeArea,
  });

  final Widget child;
  final bool useSafeArea;

  @override
  State<BoundaryStatusWidget> createState() => _BoundaryStatusWidgetState();
}

class _BoundaryStatusWidgetState extends State<BoundaryStatusWidget>
    with SingleTickerProviderStateMixin {
  InternetController controller = InternetController();
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ValueListenableBuilder<bool?>(
        valueListenable: controller.hasConnection,
        builder: (context, connected, _) {
          if (connected == null) {
            return widget.child;
          }

          if (connected) {
            return AnimatedBuilder(
              animation: _animationController,
              child: widget.child,
              builder: (ctx, child) {
                _animationController.forward();
                return Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(
                    _animationController.value < 1.0 ? 20.0 : 0.0,
                  ),
                  child: widget.child,
                );
              },
            );
          }
          _animationController.reset();
          return Container(
            color: Colors.red,
            padding: const EdgeInsets.all(20.0),
            child: widget.child,
          );
        },
      ),
    );
  }
}
