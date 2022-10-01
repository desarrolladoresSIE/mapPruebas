import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<MyLocationEvet>(
      (event, emit) => emit(
        state.copyWith(myLocation: event.myLocation),
      ),
    );
    getMyLocation();
  }

  void getMyLocation() {
    final location = Geolocator.getPositionStream();
    location.listen((event) {
      add(
        MyLocationEvet(
          myLocation: LatLng(event.latitude, event.longitude),
        ),
      );
    });
  }
}
