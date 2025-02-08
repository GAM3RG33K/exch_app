import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.error,
  });

  final Error error;

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
              context.l10n!.error_message,
              style: ShadTheme.of(context).textTheme.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n!.error_submessage,
              style: ShadTheme.of(context).textTheme.h3.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n!.error_reason(error.toString()),
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
