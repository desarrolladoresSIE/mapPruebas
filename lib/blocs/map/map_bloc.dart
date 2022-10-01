import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maput/blocs/location/location_bloc.dart';
import 'package:maput/models/search_results_model.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late LatLng markerLocation;
  final LocationBloc locationBloc;
  MapBloc({required this.locationBloc}) : super(MapState()) {
    on<SearchModelEvent>(
      (event, emit) => emit(
        state.copyWith(searchModel: event.searchModel),
      ),
    );
    on<MarkersEvent>(
      (event, emit) => emit(
        state.copyWith(markers: event.markers),
      ),
    );
    on<GoogleMapControllerEvent>(
      (event, emit) => emit(
        state.copyWith(controller: event.controller),
      ),
    );
    on<IsMoveCameraEvent>(
      (event, emit) => emit(
        state.copyWith(isMoveCamera: event.isMoveCamera),
      ),
    );
    on<ConfirmUbicationEvent>(
      (event, emit) => emit(
        state.copyWith(confirmUbication: event.confirmUbication),
      ),
    );
  }
  void controllerMap(GoogleMapController controller) {
    add(GoogleMapControllerEvent(controller: controller));
  }

  void myLocation() {
    state.controller?.animateCamera(
      CameraUpdate.newLatLng(locationBloc.state.myLocation!),
    );
  }

  void createMarker(LatLng positioned) {
     BitmapDescriptor de ;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/');
    final marker = Marker(
      markerId: const MarkerId('createMarker'),
      // icon: de,
      position: positioned,
    );

    final mapMarker = Map<String, Marker>.from(state.markers);
    mapMarker['createMarker'] = marker;
    add(MarkersEvent(markers: mapMarker));
  }
}
