part of 'permise_bloc.dart';

class PermiseState extends Equatable {
  final bool permisionActive;
  final bool locationActive;
  const PermiseState({
    this.locationActive = false,
    this.permisionActive = false,
  });

  PermiseState copyWith({bool? permisionActive, bool? locationActive}) =>
      PermiseState(
        locationActive: locationActive ?? this.locationActive,
        permisionActive: permisionActive ?? this.permisionActive,
      );
  @override
  List<Object?> get props => [permisionActive, locationActive];
}
