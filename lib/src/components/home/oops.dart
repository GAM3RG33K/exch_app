import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';

class OopsScreen extends StatelessWidget {
  const OopsScreen({
    super.key,
    this.message = "Oops! Looks like we're drawing a blank here",
    this.subMessage = "Don't worry, it happens to the best of us",
  });

  final String message;
  final String subMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_dissatisfied_rounded,
              size: 80,
              color: themeHelper.secondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: themeHelper.titleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subMessage,
              style: themeHelper.subtitleTextStyle.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
