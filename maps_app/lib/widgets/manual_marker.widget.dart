import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) => (state.displayManualMarker)
          ? const _ManualMarkerBody()
          : const SizedBox(),
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: const _ButtonBack(),
            ),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -15),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_sharp,
                  size: 40,
                ),
              ),
            ),
          ),

          /// Confirmation Button
          Positioned(
            bottom: 70,
            left: 20,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                onPressed: () async {
                  final start = locationBloc.state.lastKnownLocation;
                  if (start == null) return;

                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  showLoadingMessage(context);

                  final destination =
                      await searchBloc.getCoordsStartToEnd(start, end);

                  await mapBloc.drawRoutePolyline(destination);

                  searchBloc.add(OnDeactivateManualMarkerEvent());

                  Navigator.pop(context);
                },
                minWidth: size.width - 100,
                elevation: 0,
                shape: const StadiumBorder(),
                color: Colors.black,
                child: const Text(
                  'Confirmar destino',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonBack extends StatelessWidget {
  const _ButtonBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: MaterialButton(
        color: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: () {
          BlocProvider.of<SearchBloc>(context)
              .add(OnDeactivateManualMarkerEvent());
        },
        child: const Icon(
          Icons.close_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
