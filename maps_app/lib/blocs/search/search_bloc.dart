import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.trafficService}) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));

    on<OnDeactivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));
  }

  TrafficService trafficService;

  Future<RouteDestination> getCoordsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse =
        await trafficService.getCoordsStartToEnd(start, end);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;

    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latlngList = points
        .map((coord) => LatLng(coord[0].toDouble(), coord[1].toDouble()))
        .toList();

    return RouteDestination(
        points: latlngList, duration: duration, distance: distance);
  }
}
