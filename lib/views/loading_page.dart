import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maput/blocs/permise/permise_bloc.dart';
import 'package:maput/views/map_view.dart';
import 'package:maput/views/permision_view.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermiseBloc, PermiseState>(
      builder: (_, state) => (state.locationActive && state.permisionActive)
          ? const MapView()
          : const PermisionView(),
    );
  }
}
