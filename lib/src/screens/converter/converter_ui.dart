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
import 'package:shadcn_ui/shadcn_ui.dart';

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

  final ValueNotifier<num> exchangeRateNotifier = ValueNotifier(86);
  final ValueNotifier<num> fromAmountNotifier = ValueNotifier(1);
  final ValueNotifier<num> toAmountNotifier = ValueNotifier(1);
  Future<void> initialization() async {
    await forceOrientation(portait: true, landscape: true);
    latestRatesNotifier.value = widget.latestRates.rateInCurrency;
    latestRatesDate.value = widget.latestRates.date;
    addPostFrameCallback(
      (timeStamp) {
        final newFromCurrency = latestRates[fromCurrencyNotifier.value.abbr]!;
        final newToCurrency = latestRates[toCurrencyNotifier.value.abbr]!;
        final newExchangeRate = currencyHelper.getExchange(
          newFromCurrency,
          newToCurrency,
        );

        fromCurrencyNotifier.value = newFromCurrency;
        toCurrencyNotifier.value = newToCurrency;
        exchangeRateNotifier.value = newExchangeRate;

        handleConvert(fromAmountNotifier.value, newExchangeRate);
      },
    );
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
    return Container(
      decoration: BoxDecoration(
        color: themeHelper.backgroundColor2,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MultiNotifierBuilder(
            listenables: {
              "fromCurrency": fromCurrencyNotifier,
              "toCurrency": toCurrencyNotifier,
            },
            builder: (context, _, values) {
              final fromCurrency = values["fromCurrency"] as Currency;
              final toCurrency = values["toCurrency"] as Currency;

              return Column(
                children: [
                  // From Currency Section
                  Container(
                    decoration: BoxDecoration(
                      color: themeHelper.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: fromCurrency.abbr,
                          isExpanded: true,
                          underline: const SizedBox(),
                          dropdownColor: themeHelper.backgroundColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: themeHelper.fontColor1,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          items: currencyNameMap.keys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                "${currencySymbolMap[value]} - ${currencyNameMap[value]}",
                                style:
                                    ShadTheme.of(context).textTheme.p.copyWith(
                                          color: themeHelper.fontColor1,
                                        ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue == null) return;
                            final newCurrency = latestRates[newValue];
                            if (newCurrency == null) return;
                            fromCurrencyNotifier.value = newCurrency;
                            toCurrencyNotifier.value =
                                latestRates[toCurrency.abbr]!;
                            exchangeRateNotifier.value =
                                currencyHelper.getExchange(
                              newCurrency,
                              toCurrency,
                            );
                            handleConvert(
                              fromAmountNotifier.value,
                              exchangeRateNotifier.value,
                            );
                          },
                        ),
                        CurrencyInputCard(
                          key: UniqueKey(),
                          currency: fromCurrency,
                          initialValue: fromAmountNotifier.value,
                          onValueChange: (value) {
                            if (value.isNegative) return;
                            fromAmountNotifier.value = value;
                            handleConvert(
                              value,
                              exchangeRateNotifier.value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Swap Button
                  IconButton(
                    onPressed: () {
                      final temp = fromCurrencyNotifier.value;
                      fromCurrencyNotifier.value = toCurrencyNotifier.value;
                      toCurrencyNotifier.value = temp;
                      exchangeRateNotifier.value = currencyHelper.getExchange(
                        fromCurrencyNotifier.value,
                        toCurrencyNotifier.value,
                      );
                      handleConvert(
                        fromAmountNotifier.value,
                        exchangeRateNotifier.value,
                      );
                    },
                    icon: Icon(
                      Icons.swap_vert,
                      color: themeHelper.fontColor1,
                      size: 28,
                    ),
                  ),

                  // To Currency Section
                  Container(
                    decoration: BoxDecoration(
                      color: themeHelper.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: toCurrency.abbr,
                          isExpanded: true,
                          underline: const SizedBox(),
                          dropdownColor: themeHelper.backgroundColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: themeHelper.fontColor1,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          items: currencyNameMap.keys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                "${currencySymbolMap[value]} - ${currencyNameMap[value]}",
                                style:
                                    ShadTheme.of(context).textTheme.p.copyWith(
                                          color: themeHelper.fontColor1,
                                        ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue == null) return;
                            final newCurrency = latestRates[newValue];
                            if (newCurrency == null) return;
                            toCurrencyNotifier.value = newCurrency;
                            fromCurrencyNotifier.value =
                                latestRates[fromCurrency.abbr]!;
                            exchangeRateNotifier.value =
                                currencyHelper.getExchange(
                              fromCurrency,
                              newCurrency,
                            );
                            handleConvert(
                              fromAmountNotifier.value,
                              exchangeRateNotifier.value,
                            );
                          },
                        ),
                        ValueListenableBuilder(
                            valueListenable: toAmountNotifier,
                            builder: (context, toAmount, _) {
                              return CurrencyInputCard(
                                key: UniqueKey(),
                                currency: toCurrency,
                                initialValue: toAmount,
                                enabled: false,
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          MultiNotifierBuilder(
              listenables: {
                "latestRatesDate": latestRatesDate,
                "fromCurrency": fromCurrencyNotifier,
                "toCurrency": toCurrencyNotifier,
                "exchangeRate": exchangeRateNotifier,
              },
              builder: (context, _, values) {
                final latestRatesDate = values["latestRatesDate"] as String?;
                final fromCurrency = values["fromCurrency"] as Currency;
                final toCurrency = values["toCurrency"] as Currency;
                final exchangeRate = values["exchangeRate"] as num;
                return Column(
                  children: [
                    Text(
                      "1 ${fromCurrency.abbr} = ${exchangeRate.toStringAsFixed(6)} ${toCurrency.abbr}",
                      style: ShadTheme.of(context).textTheme.p.copyWith(
                            color: themeHelper.fontColor1,
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Updated: ${latestRatesDate ?? 'N/A'}",
                      style: ShadTheme.of(context).textTheme.p.copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                    ),
                  ],
                );
              }),
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
