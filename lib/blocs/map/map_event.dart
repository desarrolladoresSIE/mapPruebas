part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class SearchModelEvent extends MapEvent {
  final SearchResultsModel searchModel;
  const SearchModelEvent({required this.searchModel});
}

class IsMoveCameraEvent extends MapEvent {
  final bool isMoveCamera;
  const IsMoveCameraEvent({required this.isMoveCamera});
}

class GoogleMapControllerEvent extends MapEvent {
  final GoogleMapController? controller;
  const GoogleMapControllerEvent({this.controller});
}

class MarkersEvent extends MapEvent {
  final Map<String, Marker> markers;
  const MarkersEvent({required this.markers});
}


class ConfirmUbicationEvent extends MapEvent{
    final bool confirmUbication;
  const ConfirmUbicationEvent({required this.confirmUbication});
}