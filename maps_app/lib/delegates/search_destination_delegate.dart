import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/searchResult.model.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Search');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          final result = SearchResult(cancel: true);
          close(context, result);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnownLocation!;
    searchBloc.getPlacesByQuery(proximity, query);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;

        return ListView.separated(
            itemCount: places.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                title: Text(place.text),
                subtitle: Text(place.placeName),
                leading: const Icon(
                  Icons.place_outlined,
                  color: Colors.black,
                ),
                onTap: () {
                  final result = SearchResult(
                      cancel: false,
                      manual: false,
                      name: place.text,
                      description: place.placeName,
                      position: LatLng(place.center[1], place.center[0]));

                  searchBloc.add(AddToHistoryEvent(place));
                  close(context, result);
                },
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = BlocProvider.of<SearchBloc>(context).state.history;

    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black87,
          ),
          title: const Text(
            'Place location manually',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        ...history.map((place) => ListTile(
              leading: const Icon(
                Icons.history_outlined,
                color: Colors.black87,
              ),
              title: Text(
                place.placeName,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                final result = SearchResult(
                    cancel: false,
                    manual: false,
                    name: place.text,
                    description: place.placeName,
                    position: LatLng(place.center[1], place.center[0]));

                close(context, result);
              },
            ))
      ],
    );
  }
}
