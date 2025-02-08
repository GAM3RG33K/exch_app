import 'package:exch_app/src/constants.dart';
import 'package:flutter/material.dart';

class MultiNotifierBuilder extends StatelessWidget {
  final Map<String, ValueNotifier> listenables;
  final MultiListenableWidgetBuilder builder;

  const MultiNotifierBuilder({
    super.key,
    required this.listenables,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(listenables.values),
      builder: (context, child) {
        return builder(context, child, listenableValues);
      },
    );
  }

  Map<String, dynamic> get listenableValues {
    final valueList = listenables.entries
        .map(
          (e) => MapEntry(e.key, e.value.value),
        )
        .toList();
    return Map.fromEntries(valueList);
  }
}
