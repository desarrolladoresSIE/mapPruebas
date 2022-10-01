part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng? myLocation;
  const LocationState({this.myLocation});

  LocationState copyWith({LatLng? myLocation}) =>
      LocationState(myLocation: myLocation ?? this.myLocation);
  @override
  List<Object?> get props => [myLocation];
}
