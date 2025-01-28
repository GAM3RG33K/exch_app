import 'dart:math';

import 'package:exch_app/src/components/home/currency_input_card.dart';
import 'package:exch_app/src/models/api/rates_data.dart';
import 'package:exch_app/src/models/currency.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:exch_app/src/utils/application/orientation_helper.dart';
import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:exch_app/src/utils/application/widgets/multi_listenable_builder.dart';
import 'package:exch_app/src/utils/domain/currencies.dart';
import 'package:exch_app/src/utils/domain/currency_helper.dart';
import 'package:exch_app/src/utils/logger/logger.dart';
import 'package:flutter/material.dart';

class ConverterUI extends StatefulWidget {
  final RatesData latestRates;
  const ConverterUI({super.key, required this.latestRates});

  @override
  State<ConverterUI> createState() => _ConverterUIState();
}

class _ConverterUIState extends ResponsiveState<ConverterUI> {
  final ValueNotifier<Map<String, Currency>> latestRatesNotifier =
      ValueNotifier({});
  final ValueNotifier<String?> latestRatesDate = ValueNotifier(null);

  final ValueNotifier<Currency> fromCurrencyNotifier = ValueNotifier(
    Currency.fromAbbr(abbr: "USD", rate: 1),
  );
  final ValueNotifier<Currency> toCurrencyNotifier = ValueNotifier(
    Currency.fromAbbr(abbr: "INR", rate: 1),
  );

  final ValueNotifier<num> exchangeRate = ValueNotifier(86);
  final ValueNotifier<num> fromAmountNotifier = ValueNotifier(1);
  final ValueNotifier<num> toAmountNotifier = ValueNotifier(1);
  Future<void> initialization() async {
    await forceOrientation(portait: true, landscape: true);
    latestRatesNotifier.value = widget.latestRates.rateInCurrency;
    latestRatesDate.value = widget.latestRates.date;
    handleConvert(fromAmountNotifier.value, exchangeRate.value);
  }

  Map<String, Currency> get latestRates => latestRatesNotifier.value;

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  void dispose() {
    forceOrientation(portait: true, landscape: true);
    super.dispose();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return buildMobile(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MultiNotifierBuilder(
                  listenables: {
                    "fromCurrency": fromCurrencyNotifier,
                    "toCurrency": toCurrencyNotifier,
                    "fromAmount": fromAmountNotifier,
                    "toAmount": toAmountNotifier,
                  },
                  builder: (context, _, values) {
                    final fromCurrency = values["fromCurrency"] as Currency;
                    final fromAmount = values["fromAmount"] as num;
                    final toCurrency = values["toCurrency"] as Currency;
                    final toAmount = values["toAmount"] as num;

                    return Column(
                      children: [
                        CurrencyInputCard(
                          key: UniqueKey(),
                          currency: fromCurrency,
                          initialValue: fromAmount,
                          onValueChange: (value) {
                            if (value.isNegative) {
                              return;
                            }
                            fromAmountNotifier.value = value;
                            handleConvert(value, exchangeRate.value);
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: themeHelper.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: fromCurrency.abbr,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: themeHelper.fontColor1,
                            ),
                            dropdownColor: themeHelper.backgroundColor,
                            onChanged: (String? newValue) {
                              setState(() {
                                final newCurrency = latestRates[newValue!];
                                if (newCurrency == null) return;
                                fromCurrencyNotifier.value = newCurrency;
                                exchangeRate.value = currencyHelper.getExchange(
                                    newCurrency, toCurrency);
                              });
                            },
                            items: currencyNameMap.keys
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  "${currencySymbolMap[value]} - $value",
                                  style: themeHelper.subtitleTextStyle.copyWith(
                                    color: themeHelper.fontColor1,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: Icon(
                              Icons.swap_horiz,
                              color: themeHelper.fontColor1,
                            ),
                          ),
                        ),
                        CurrencyInputCard(
                          key: UniqueKey(),
                          currency: toCurrency,
                          initialValue: toAmount,
                          onValueChange: (value) {},
                          enabled: false,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: themeHelper.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: toCurrency.abbr,
                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: themeHelper.fontColor1,
                            ),
                            dropdownColor: themeHelper.backgroundColor,
                            onChanged: (String? newValue) {
                              setState(() {
                                final newCurrency = latestRates[newValue!];
                                if (newCurrency == null) return;
                                toCurrencyNotifier.value = newCurrency;
                                exchangeRate.value = currencyHelper.getExchange(
                                    fromCurrency, newCurrency);
                              });
                            },
                            items: currencyNameMap.keys
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  "${currencySymbolMap[value]} - $value",
                                  style: themeHelper.subtitleTextStyle.copyWith(
                                    color: themeHelper.fontColor1,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: ValueListenableBuilder(
              valueListenable: latestRatesDate,
              builder: (context, value, _) {
                return Text.rich(
                  TextSpan(
                    style: themeHelper.bodyTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      const TextSpan(text: "Exchange rate as of "),
                      TextSpan(
                        text: value ?? "",
                        style: TextStyle(
                          color: themeHelper.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleConvert(num fromAmount, num exchangeRate) {
    log("handleConvert: $fromAmount, $exchangeRate");
    final result = fromAmount * exchangeRate;
    toAmountNotifier.value = result;
  }
}
