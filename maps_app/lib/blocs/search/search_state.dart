part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState(
      {this.displayManualMarker = false,
      this.places = const [],
      this.history = const []});

  final bool displayManualMarker;
  final List<Feature> places;
  final List<Feature> history;

  SearchState copyWith(
          {bool? displayManualMarker,
          List<Feature>? places,
          List<Feature>? history}) =>
      SearchState(
        displayManualMarker: displayManualMarker ?? this.displayManualMarker,
        history: history ?? this.history,
        places: places ?? this.places,
      );

  @override
  List<Object> get props => [displayManualMarker, places, history];
}
