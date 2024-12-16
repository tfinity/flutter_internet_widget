import 'package:flutter/material.dart';
import 'package:internet_widget/src/enum/internet_widget_type.dart';
import 'package:internet_widget/src/widgets/bottom_overlay_widget.dart';
import 'package:internet_widget/src/widgets/bottom_status_widget.dart';
import 'package:internet_widget/src/widgets/boundary_overlay_widget.dart';
import 'package:internet_widget/src/widgets/boundary_status_widget.dart';
import 'package:internet_widget/src/widgets/top_overlay_widget.dart';
import 'package:internet_widget/src/widgets/top_status_widget.dart';

class InternetWidget extends StatelessWidget {
  const InternetWidget({
    super.key,
    required this.child,
    this.widgetType = InternetWidgetType.bottomStatusWidget,
    this.useSafeArea = true,
  });

  final Widget child;
  final InternetWidgetType widgetType;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return switch (widgetType) {
      InternetWidgetType.bottomStatusWidget => BottomStatusWidget(
          useSafeArea: useSafeArea,
          child: child,
        ),
      InternetWidgetType.bottomOverlayWidget => BottomOverlayWidget(
          useSafeArea: useSafeArea,
          child: child,
        ),
      InternetWidgetType.topStatusWidget => TopStatusWidget(
          useSafeArea: useSafeArea,
          child: child,
        ),
      InternetWidgetType.topOverlayWidget => TopOverlayWidget(
          useSafeArea: useSafeArea,
          child: child,
        ),
      InternetWidgetType.boundaryStatusWidget => BoundaryStatusWidget(
          useSafeArea: useSafeArea,
          child: child,
        ),
      InternetWidgetType.boundaryOverlayWidget => BoundaryOverlayWidget(
          useSafeArea: useSafeArea,
          child: child,
        ),
    };
  }
}
