import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.error,
    this.message = "Something went wrong!",
  });

  final Error error;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied_rounded,
              size: 80,
              color: themeHelper.secondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: ShadTheme.of(context).textTheme.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Don't worry, We are looking into it",
              style: ShadTheme.of(context).textTheme.h3.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "Reason: \n$error",
              style: ShadTheme.of(context).textTheme.h3.copyWith(
                color: themeHelper.secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
