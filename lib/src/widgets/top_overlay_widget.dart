import 'package:flutter/material.dart';
import 'package:internet_widget/src/controller/internet_controller.dart';
import 'package:internet_widget/src/widgets/common_top_widget.dart';

class TopOverlayWidget extends StatefulWidget {
  const TopOverlayWidget({
    super.key,
    required this.child,
    required this.useSafeArea,
  });

  final Widget child;
  final bool useSafeArea;

  @override
  State<TopOverlayWidget> createState() => _TopOverlayWidgetState();
}

class _TopOverlayWidgetState extends State<TopOverlayWidget>
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
            top: 0,
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
                    child: CommonTopWidget(
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
                return CommonTopWidget(
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
