part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController mapController;

  const OnMapInitializedEvent(this.mapController);
}

class OnStartFollowingUser extends MapEvent {}

class OnStopFollowingUser extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> locationHistory;

  const UpdateUserPolylineEvent(this.locationHistory);
}

class OnToggleUserRoute extends MapEvent {}
