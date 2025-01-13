import 'package:flutter/material.dart';
import 'package:exch_app/src/utils/utils.dart';

class SmallLoader extends StatefulWidget {
  final EdgeInsets? padding;
  const SmallLoader({super.key, this.padding});

  @override
  State<SmallLoader> createState() => _SmallLoaderState();
}

class _SmallLoaderState extends State<SmallLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Color> _colors = themeHelper.loaderColors;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final outerPadding = widget.padding ?? EdgeInsets.zero;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        final double progress = (_controller.value -
                _colors.length * (1 / _colors.length)) /
            ((1 - (1 / _colors.length)) - _colors.length * 1 / _colors.length);
        final int colorIndex =
            (_colors.length * (progress % 1)).floor() % _colors.length;
        return Padding(
          padding: outerPadding,
          child: Center(
            child: CircularProgressIndicator(
              color: _colors[colorIndex],
              valueColor: AlwaysStoppedAnimation(_colors[colorIndex]),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
