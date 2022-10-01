import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maput/blocs/location/location_bloc.dart';
import 'package:maput/blocs/map/map_bloc.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        final camera = CameraPosition(target: state.myLocation!, zoom: 14);
        return Listener(
          onPointerMove: (_) =>
              mapBloc.add(const IsMoveCameraEvent(isMoveCamera: true)),
          child: _MapGoogle(mapBloc: mapBloc, camera: camera),
        );
      },
    );
  }
}

class _MapGoogle extends StatelessWidget {
  const _MapGoogle({
    Key? key,
    required this.mapBloc,
    required this.camera,
  }) : super(key: key);

  final MapBloc mapBloc;
  final CameraPosition camera;

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          onCameraMove: (cameraPosition) =>
              mapBloc.markerLocation = cameraPosition.target,
          markers: state.markers.values.toSet(),
          onMapCreated: ((controller) => mapBloc.controllerMap(controller)),
          initialCameraPosition: camera,
          myLocationEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          myLocationButtonEnabled: false,
        );
      },
    );
  }
}
