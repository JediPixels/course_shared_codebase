import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ChangeMetricsObserver
class ChangeMetricsObserver extends StatefulWidget {
  /// Used to observe screen size changes.
  /// Currently used for web only to pop() any current navigated page
  /// if screen size is not mobile.
  /// The [enableObserver] is used to Add Observer, if false no observer is added.
  /// The [didChangeMetricsCallback] is called on screen size changes
  /// and returns if platform running is web.
  /// The [child] widget is the page or widget to observe.
  const ChangeMetricsObserver({
    super.key,
    required this.enableObserver,
    required this.didChangeMetricsCallback,
    required this.child,
  });

  final bool enableObserver;
  final Function(bool isWeb) didChangeMetricsCallback;
  final Widget child;

  @override
  State<ChangeMetricsObserver> createState() => _ChangeMetricsObserverState();
}

class _ChangeMetricsObserverState extends State<ChangeMetricsObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    if (widget.enableObserver) WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (widget.enableObserver) WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    widget.didChangeMetricsCallback(kIsWeb);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
