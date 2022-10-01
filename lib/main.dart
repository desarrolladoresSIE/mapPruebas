import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maput/blocs/location/location_bloc.dart';
import 'package:maput/blocs/map/map_bloc.dart';
import 'package:maput/blocs/permise/permise_bloc.dart';
import 'package:maput/views/loading_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermiseBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => MapBloc(
            locationBloc: BlocProvider.of<LocationBloc>(context),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map',
      initialRoute: '/permision',
      routes: {
        '/permision': (_) => const LoadingPage(),
      },
    );
  }
}
