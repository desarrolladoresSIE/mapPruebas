import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResultsModel {
  final bool isMarketManual;
  final LatLng? route;
  SearchResultsModel({this.isMarketManual = false, this.route});
}
