import 'package:flutter/material.dart';
import 'package:internet_widget/src/controller/internet_controller.dart';
import 'package:internet_widget/src/widgets/common_bottom_widget.dart';

class BottomOverlayWidget extends StatefulWidget {
  const BottomOverlayWidget({
    super.key,
    required this.child,
    required this.useSafeArea,
  });

  final Widget child;
  final bool useSafeArea;

  @override
  State<BottomOverlayWidget> createState() => _BottomOverlayWidgetState();
}

class _BottomOverlayWidgetState extends State<BottomOverlayWidget>
    with SingleTickerProviderStateMixin {
  InternetController controller = InternetController();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool?>(
              valueListenable: controller.hasConnection,
              builder: (context, connected, _) {
                if (connected == null) {
                  return const SizedBox();
                }

                if (connected) {
                  return AnimatedBuilder(
                    animation: _controller,
                    child: CommonBottomWidget(
                      color: Colors.green,
                      height: 20,
                      text: 'Internet Connected',
                      useSafeArea: widget.useSafeArea,
                    ),
                    builder: (ctx, child) {
                      _controller.forward();
                      return _controller.value < 1.0
                          ? child!
                          : const SizedBox.shrink();
                    },
                  );
                }
                _controller.reset();
                return CommonBottomWidget(
                  color: Colors.red,
                  height: 20,
                  text: 'No Internet Connection',
                  useSafeArea: widget.useSafeArea,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
