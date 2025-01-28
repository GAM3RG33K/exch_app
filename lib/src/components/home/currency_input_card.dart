import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter/material.dart';

class CurrencyInputCard extends StatefulWidget {
  const CurrencyInputCard({
    super.key,
    required this.currency,
    required this.initialValue,
    this.onValueChange,
    this.enabled = true,
  });

  final Currency currency;
  final bool enabled;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ShadInput(
        controller: controller,
        enabled: widget.enabled,
        autofocus: widget.enabled,
        onChanged: (value) =>
            widget.onValueChange?.call(num.tryParse(value) ?? 0.0),
        style: ShadTheme.of(context).textTheme.h2.copyWith(
              fontSize: 32,
              color: themeHelper.fontColor1,
            ),
        cursorColor: themeHelper.primaryColor,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        decoration: const ShadDecoration(
          border: ShadBorder.none,
        ),
      ),
    );
  }
}
