part of 'permise_bloc.dart';

abstract class PermiseEvent extends Equatable {
  const PermiseEvent();

  @override
  List<Object> get props => [];
}

class LocationPermiseEvent extends PermiseEvent {
  final bool locationActive;
  const LocationPermiseEvent({required this.locationActive});
}

class PermisionActiveEvent extends PermiseEvent {
  final bool permiseActive;
  const PermisionActiveEvent({required this.permiseActive});
}
