import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maput/models/search_results_model.dart';

class SearchDelegateMap extends SearchDelegate<SearchResultsModel> {
  SearchDelegateMap()
      : super(
            searchFieldLabel: 'Buscar...',
            searchFieldStyle: const TextStyle(fontSize: 17));
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      CloseButton(
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () =>
          close(context, SearchResultsModel(isMarketManual: false)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (query == '')
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Busca lugares cercanos a tu casa de cambio...',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 77, 77, 77)),
                    textAlign: TextAlign.center,
                  ),
                  Lottie.asset('assets/gps-navigation.json', height: 240)
                ],
              ),
            ),
          )
        : Container();
  }
}
