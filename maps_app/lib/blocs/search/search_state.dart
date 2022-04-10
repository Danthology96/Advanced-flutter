part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({this.displayManualMarker = false});

  final bool displayManualMarker;

  SearchState copyWith({bool? displayManualMarker}) => SearchState(
      displayManualMarker: displayManualMarker ?? this.displayManualMarker);

  @override
  List<Object> get props => [displayManualMarker];
}
