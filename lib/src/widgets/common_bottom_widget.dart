import 'package:flutter/material.dart';

class CommonBottomWidget extends StatelessWidget {
  const CommonBottomWidget({
    super.key,
    required this.color,
    required this.height,
    required this.text,
    required this.useSafeArea,
  });
  final Color color;
  final double height;
  final String text;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height:
          height + (useSafeArea ? MediaQuery.of(context).padding.bottom : 0),
      width: double.infinity,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
