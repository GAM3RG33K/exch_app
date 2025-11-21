import 'package:exch_app/src/utils/application/theme_helper.dart';
import 'package:exch_app/src/utils/domain/currencies.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CurrencySelectionPage extends StatefulWidget {
  static const String routeName = '/currency-selection';

  final String selectedCurrency;
  final String title;

  const CurrencySelectionPage({
    super.key,
    required this.selectedCurrency,
    required this.title,
  });

  @override
  State<CurrencySelectionPage> createState() => _CurrencySelectionPageState();

  // Add a constructor to handle route arguments
  static CurrencySelectionPage fromRouteArguments(
    Map<String, dynamic> arguments,
  ) {
    return CurrencySelectionPage(
      selectedCurrency: arguments['selectedCurrency'] as String,
      title: arguments['title'] as String,
    );
  }
}

class _CurrencySelectionPageState extends State<CurrencySelectionPage> {
  final searchController = TextEditingController();
  final ValueNotifier<List<String>> filteredCurrencies =
      ValueNotifier(currencyNameMap.keys.toList());

  void filterCurrencies(String query) {
    if (query.isEmpty) {
      filteredCurrencies.value = currencyNameMap.keys.toList();
      return;
    }

    filteredCurrencies.value = currencyNameMap.entries
        .where((entry) {
          final name = entry.value.toLowerCase();
          final abbr = entry.key.toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || abbr.contains(searchQuery);
        })
        .map((e) => e.key)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeHelper.backgroundColor2,
      appBar: AppBar(
        backgroundColor: themeHelper.backgroundColor,
        title: Text(
          widget.title,
          style: ShadTheme.of(context).textTheme.h3,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShadInput(
              controller: searchController,
              onChanged: filterCurrencies,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: filteredCurrencies,
        builder: (context, currencies, _) {
          return Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currencyCode = currencies[index];
                final isSelected = currencyCode == widget.selectedCurrency;

                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: isSelected
                      ? themeHelper.primaryColor.withOp(0.1)
                      : null,
                  title: Text(
                    "${currencySymbolMap[currencyCode]} - ${currencyNameMap[currencyCode]}",
                    style: ShadTheme.of(context).textTheme.p.copyWith(
                          color: themeHelper.fontColor1,
                        ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: themeHelper.primaryColor,
                        )
                      : null,
                  onTap: () {
                    Navigator.of(context).pop(currencyCode);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
