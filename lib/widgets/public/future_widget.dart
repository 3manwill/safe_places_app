import 'package:flutter/material.dart';

class FutureWidget<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(T? data) successBuilder;
  final Widget? Function(dynamic error)? errorBuilder;
  final Widget? loadingWidget;

  const FutureWidget({
    super.key,
    required this.future,
    required this.successBuilder,
    this.errorBuilder,
    this.loadingWidget,
  });

  @override
  State<FutureWidget<T>> createState() => _FutureWidgetState<T>();
}

class _FutureWidgetState<T> extends State<FutureWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ?? const SizedBox();
        } else if (snapshot.hasData || snapshot.connectionState == ConnectionState.done) {
          return widget.successBuilder(snapshot.data);
        } else if (snapshot.hasError) {
          return widget.errorBuilder!(snapshot.error) ?? const SizedBox();
        }

        return const Text('Wrong builder');
      },
    );
  }
}
