part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnActivateManualMarkerEvent extends SearchEvent {}

class OnDeactivateManualMarkerEvent extends SearchEvent {}

class OnNewPlacesEvent extends SearchEvent {
  const OnNewPlacesEvent(this.places);
  final List<Feature> places;
}

class AddToHistoryEvent extends SearchEvent {
  const AddToHistoryEvent(this.place);
  final Feature place;
}

/// TODO: Add to history event
/// final Feature place
