import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:flutter/material.dart';
import '../loaders.dart';

class FetchingRatesLoader extends StatelessWidget {
  const FetchingRatesLoader({
    super.key,
    this.message = "Crunching numbers at light speed",
    this.subMessage = "Hold tight while we fetch the latest rates",
  });

  final String message;
  final String subMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SmallLoader(
            padding: EdgeInsets.symmetric(vertical: 24),
          ),
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
    );
  }
}
