part of 'map_bloc.dart';

class MapState extends Equatable {
  final SearchResultsModel searchModel;
  final bool isMoveCamera;
  final bool confirmUbication;
  final Map<String, Marker> markers;
  final GoogleMapController? controller;
  MapState({
    SearchResultsModel? searchModel,
    this.controller,
    this.confirmUbication = false,
    this.isMoveCamera = false,
    this.markers = const {},
  }) : searchModel = searchModel ?? SearchResultsModel();

  MapState copyWith({
    final SearchResultsModel? searchModel,
    GoogleMapController? controller,
    Map<String, Marker>? markers,
    bool? confirmUbication,
    bool? isMoveCamera,
  }) =>
      MapState(
        searchModel: searchModel ?? this.searchModel,
        controller: controller ?? this.controller,
        isMoveCamera: isMoveCamera ?? this.isMoveCamera,
        markers: markers ?? this.markers,
        confirmUbication: confirmUbication ?? this.confirmUbication,
      );
  @override
  List<Object?> get props => [
        searchModel,
        controller,
        isMoveCamera,
        markers,
        confirmUbication,
      ];
}
