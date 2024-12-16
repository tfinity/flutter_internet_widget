import 'package:flutter/material.dart';

class CommonTopWidget extends StatelessWidget {
  const CommonTopWidget({
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
      padding: EdgeInsets.only(
          top: height + (useSafeArea ? MediaQuery.of(context).padding.top : 0)),
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
