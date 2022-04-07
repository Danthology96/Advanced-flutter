part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState(
      {this.isMapInitialized = false,
      this.isFollowingUser = true,
      this.showMyRoute = false,
      Map<String, Polyline>? polylines})
      : polylines = polylines ?? const {};

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  /// polylines
  final Map<String, Polyline> polylines;
  /*
    'route': {
      id: polylineID Google,
      points: [ [lat,lng], ...],
      width: 3,
      color: black
    }
  */

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    Map<String, Polyline>? polylines,
    bool? showMyRoute,
  }) =>
      MapState(
          isMapInitialized: isMapInitialized ?? this.isMapInitialized,
          isFollowingUser: isFollowingUser ?? this.isFollowingUser,
          showMyRoute: showMyRoute ?? this.showMyRoute,
          polylines: polylines ?? this.polylines);

  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showMyRoute, polylines];
}
