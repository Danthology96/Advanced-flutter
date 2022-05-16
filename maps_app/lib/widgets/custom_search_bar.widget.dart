import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) => state.displayManualMarker
          ? const SizedBox()
          : const _CustomSearchBarBody(),
    );
  }
}

class _CustomSearchBarBody extends StatelessWidget {
  const _CustomSearchBarBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());

            if (result == null) return;

            onSearchResults(context, result);
          },
          child: FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text('¿Dónde quieres ir?',
                  style: TextStyle(color: Colors.black87)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final start = locationBloc.state.lastKnownLocation!;

      final destination =
          await searchBloc.getCoordsStartToEnd(start, result.position!);

      await mapBloc.drawRoutePolyline(destination);
      return;
    }
  }
}
