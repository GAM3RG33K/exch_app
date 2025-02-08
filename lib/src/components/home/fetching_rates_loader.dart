import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../loaders.dart';

class FetchingRatesLoader extends StatelessWidget {
  const FetchingRatesLoader({
    super.key,
  });

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
            context.l10n!.converter_loading_message,
            style: ShadTheme.of(context).textTheme.h3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n!.converter_loading_submessage,
            style: ShadTheme.of(context).textTheme.p.copyWith(
                  color: Colors.grey,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
