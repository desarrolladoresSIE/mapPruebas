part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object> get props => [];
}
class MyLocationEvet extends LocationEvent{
  final LatLng myLocation;
  const MyLocationEvet({required this.myLocation});
}