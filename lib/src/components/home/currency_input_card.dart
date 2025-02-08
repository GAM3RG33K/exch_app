import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:exch_app/src/utils/network/analytics_helper.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter/material.dart';

class CurrencyInputCard extends StatefulWidget {
  const CurrencyInputCard({
    super.key,
    required this.currency,
    required this.initialValue,
    this.onValueChange,
    this.enabled = true,
    this.allowCopy = false,
  });

  final Currency currency;
  final bool enabled;
  final bool allowCopy;
  final num initialValue;
  final ValueChanged<num>? onValueChange;

  @override
  State<CurrencyInputCard> createState() => _CurrencyInputCardState();
}

class _CurrencyInputCardState extends State<CurrencyInputCard> {
  late String selectedCurrencyAbbr;
  final TextEditingController controller = TextEditingController();

  String get initialValue =>
      widget.initialValue.toStringAsFixed(!widget.enabled ? 2 : 0);
  @override
  void initState() {
    super.initState();
    selectedCurrencyAbbr = widget.currency.abbr;
    controller.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.allowCopy
          ? () {
              analyticsHelper?.logDataCopied();
              Clipboard.setData(
                ClipboardData(
                  text: controller.text,
                ),
              );
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ShadInput(
          controller: controller,
          enabled: widget.enabled,
          autofocus: widget.enabled,
          onChanged: (value) =>
              widget.onValueChange?.call(num.tryParse(value) ?? 0.0),
          style: ShadTheme.of(context).textTheme.h2.copyWith(
                fontSize: 32,
                color: widget.enabled
                    ? themeHelper.fontColor1
                    : themeHelper.primaryColor,
              ),
          cursorColor: themeHelper.primaryColor,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: const TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
          decoration: const ShadDecoration(
            border: ShadBorder.none,
          ),
          suffix: !widget.allowCopy
              ? null
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.copy_outlined,
                    size: 24,
                    color: themeHelper.primaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}
