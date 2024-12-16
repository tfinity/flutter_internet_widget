import 'package:flutter/material.dart';
import 'package:internet_widget/src/controller/internet_controller.dart';
import 'package:internet_widget/src/painters/boundary_overlay_painter.dart';

class BoundaryOverlayWidget extends StatefulWidget {
  const BoundaryOverlayWidget({
    super.key,
    required this.child,
    required this.useSafeArea,
  });

  final Widget child;
  final bool useSafeArea;

  @override
  State<BoundaryOverlayWidget> createState() => _BoundaryOverlayWidgetState();
}

class _BoundaryOverlayWidgetState extends State<BoundaryOverlayWidget>
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
            _animationController.forward();
            return AnimatedBuilder(
              animation: _animationController,
              builder: (ctx, _) {
                return CustomPaint(
                  foregroundPainter: BoundaryOverlayPainter(
                    color: Colors.green,
                    shouldPaint: _animationController.value < 1.0,
                    safeAreaTop: widget.useSafeArea
                        ? MediaQuery.paddingOf(context).top
                        : 0.0,
                    safeAreaBottom: widget.useSafeArea
                        ? MediaQuery.paddingOf(context).bottom
                        : 0.0,
                  ),
                  child: widget.child,
                );
              },
            );
          }
          _animationController.reset();
          return CustomPaint(
            foregroundPainter: BoundaryOverlayPainter(
              color: Colors.red,
              safeAreaTop:
                  widget.useSafeArea ? MediaQuery.paddingOf(context).top : 0.0,
              safeAreaBottom: widget.useSafeArea
                  ? MediaQuery.paddingOf(context).bottom
                  : 0.0,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}
