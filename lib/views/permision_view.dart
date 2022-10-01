import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:maput/blocs/permise/permise_bloc.dart';

class PermisionView extends StatelessWidget {
  const PermisionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PermiseBloc, PermiseState>(
        builder: (_, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: IndexedStack(
            index: (!state.locationActive) ? 0 : 1,
            children: [
              _LocationPermise(),
              _Permision(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationPermise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text.rich(
          TextSpan(
            text: 'Es necesario tener encendido el ',
            style: TextStyle(
              fontSize: 23,
            ),
            children: [
              TextSpan(
                text: 'GPS ',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: 'para inicar con la app',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Opacity(
          opacity: 0.6,
          child: Lottie.asset('assets/gps.json', height: 200),
        )
      ],
    );
  }
}

class _Permision extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final permisionBloc = BlocProvider.of<PermiseBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text.rich(
          TextSpan(
            text: 'Es necesario otorgar permisos para ',
            style: TextStyle(
              fontSize: 23,
            ),
            children: [
              TextSpan(
                text: 'Acceder a la app ',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Lottie.asset('assets/permisionGps.json', height: 300),
        const SizedBox(height: 20),
        MaterialButton(
          onPressed: () async {
            await permisionBloc.permisionLocation();
          },
          color: Colors.blueGrey,
          shape: const StadiumBorder(),
          textColor: Colors.white,
          height: 40,
          textTheme: ButtonTextTheme.primary,
          child: const Text('Otorgar permisos'),
        )
      ],
    );
  }
}
