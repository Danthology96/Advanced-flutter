import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key, required this.initialLocation}) : super(key: key);

  final LatLng initialLocation;

  @override
  Widget build(BuildContext context) {
    final initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    final size = MediaQuery.of(context).size;

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
        width: size.width,
        height: size.height,
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),

          /// TODO: Markers
          /// TODO: Polylines
          /// TODO: map movement
        ));
  }
}
