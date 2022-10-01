import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maput/blocs/location/location_bloc.dart';
import 'package:maput/views/search_delegate_map.dart';
import 'package:maput/widgets/map_widget.dart';

import '../blocs/map/map_bloc.dart';
import '../widgets/btn_map_widget.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return (state.myLocation != null)
              ? const _MapRegister()
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class _MapRegister extends StatelessWidget {
  const _MapRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, stateMap) {
        return Stack(
          children: [
            const MapWidget(),
            const _SearchDelegeteMap(),
            const _BtnMyLocation(),
            (stateMap.confirmUbication) ? Container() : const _MarkerLocation(),
            const _BtnSaveUbication(),
            
          ],
        );
      },
    );
  }
}

class _BtnMyLocation extends StatelessWidget {
  const _BtnMyLocation();

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(
      builder: (_, state) => Positioned(
        right: 10,
        bottom: 90,
        child: CircleAvatar(
          backgroundColor: (state.isMoveCamera) ? Colors.white : Colors.black,
          child: IconButton(
            tooltip: 'Regresar a mi ubicación',
            onPressed: () {
              mapBloc.myLocation();
              mapBloc.add(const IsMoveCameraEvent(isMoveCamera: false));
            },
            icon: const Icon(Icons.location_searching_rounded),
          ),
        ),
      ),
    );
  }
}

class _BtnSaveUbication extends StatelessWidget {
  const _BtnSaveUbication();

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (!state.confirmUbication)
                    FadeInDown(
                      child: BtnMapWidget(
                        text: 'marcar ubicación',
                        icon: Icons.add_location_alt,
                        onPressed: () async {
                          mapBloc.add(
                            const ConfirmUbicationEvent(confirmUbication: true),
                          );
                          mapBloc.createMarker(mapBloc.markerLocation);
                        },
                      ),
                    ),
                  if (state.confirmUbication) ...[
                    FadeInLeft(
                      child: BtnMapWidget(
                        text: 'marcar de nuevo',
                        icon: Icons.location_off_sharp,
                        onPressed: () async {
                          final marker =
                              Map<String, Marker>.from(state.markers);
                          marker.remove('createMarker');
                          mapBloc.add(MarkersEvent(markers: marker));
                          mapBloc.add(
                            const ConfirmUbicationEvent(
                                confirmUbication: false),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 50),
                    FadeInRight(
                      child: BtnMapWidget(
                        text: 'Guardar',
                        icon: Icons.add_location_alt,
                        onPressed: () async {
                          mapBloc.createMarker(mapBloc.markerLocation);
                        },
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MarkerLocation extends StatelessWidget {
  const _MarkerLocation();

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      child: Center(
        child: Transform.translate(
          offset: const Offset(0, -21),
          child: const Icon(
            Icons.location_pin,
            size: 50,
          ),
        ),
      ),
    );
  }
}

class _SearchDelegeteMap extends StatelessWidget {
  const _SearchDelegeteMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          final result = await showSearch(
            context: context,
            delegate: SearchDelegateMap(),
          );
          mapBloc.add(SearchModelEvent(searchModel: result!));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: const [
              Icon(Icons.search),
              SizedBox(width: 10),
              Text('Buscar lugares...'),
            ],
          ),
        ),
      ),
    );
  }
}
