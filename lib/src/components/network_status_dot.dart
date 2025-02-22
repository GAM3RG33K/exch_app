import 'package:exch_app/src/repositories/rates_repository.dart';
import 'package:exch_app/src/utils/notification/notification_helper.dart';
import 'package:flutter/material.dart';

class NetworkStatusDot extends StatelessWidget {
  final RatesRepository ratesRepository;
  final bool isOnline;
  const NetworkStatusDot({
    super.key,
    required this.isOnline,
    required this.ratesRepository,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ratesRepository.isFetching,
      builder: (context, _) {
        final isFetching = ratesRepository.isFetching.value;

        Color dotColor;
        bool shouldBlink = false;

        if (isFetching) {
          dotColor = Colors.yellow;
          shouldBlink = true;
        } else if (isOnline) {
          dotColor = Colors.green;
        } else {
          dotColor = Colors.red;
        }

        return GestureDetector(
          onTap: () => showMessage(isOnline, isFetching),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: AbsorbPointer(
              child: _NetworkDot(
                color: dotColor,
                shouldBlink: shouldBlink,
              ),
            ),
          ),
        );
      },
    );
  }

  void showMessage(bool isOnline, bool isFetching) {
    if (isFetching) {
      showShortToast("Fetching exchange rates");
    } else {
      showShortToast("Internet Connectivity: ${isOnline ? "ON" : "OFF"}");
    }
  }
}

class _NetworkDot extends StatefulWidget {
  final Color color;
  final bool shouldBlink;

  const _NetworkDot({
    required this.color,
    required this.shouldBlink,
  });

  @override
  State<_NetworkDot> createState() => _NetworkDotState();
}

class _NetworkDotState extends State<_NetworkDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);

    if (widget.shouldBlink) {
      _controller.repeat(reverse: true);
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_NetworkDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldBlink) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
