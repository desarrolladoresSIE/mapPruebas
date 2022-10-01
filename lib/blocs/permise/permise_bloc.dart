import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permise_event.dart';
part 'permise_state.dart';

class PermiseBloc extends Bloc<PermiseEvent, PermiseState> {
  late StreamSubscription locationListen;
  PermiseBloc() : super(const PermiseState()) {
    on<LocationPermiseEvent>(
      (event, emit) => emit(
        state.copyWith(locationActive: event.locationActive),
      ),
    );
    on<PermisionActiveEvent>(
      (event, emit) => emit(
        state.copyWith(permisionActive: event.permiseActive),
      ),
    );
    init();
  }

  void init() async {
    final data = await Future.wait([
      _locationActive(),
      _permiseIsActive(),
    ]);
    add(LocationPermiseEvent(locationActive: data[0]));
    add(PermisionActiveEvent(permiseActive: data[1]));
  }

  Future<bool> _permiseIsActive() async {
    return await Permission.location.isGranted;
  }

  Future<bool> _locationActive() async {
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    final location = Geolocator.getServiceStatusStream();
    locationListen =  location.listen((event) {
      final active = (event.index == 0) ? false : true;
      add(LocationPermiseEvent(locationActive: active));
    });
    return gpsActive;
  }

  Future permisionLocation() async {
    final permise = await Permission.location.request();
    if (permise.isGranted) {
      add(const PermisionActiveEvent(permiseActive: true));
    } else {
      add(const PermisionActiveEvent(permiseActive: false));
      openAppSettings();
    }
  }

  @override
  Future<void> close() {
    locationListen.cancel();
    return super.close();
  }
}
