import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/ui/ui.dart';

class ButtonCurrentLocation extends StatelessWidget {
  const ButtonCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            onPressed: () {
              final userLocation = locationBloc.state.lastKnownLocation;

              if (userLocation == null) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(CustomSnackbar(message: 'No location found'));
                return;
              }
              mapBloc.moveCamera(userLocation);
            },
            icon: const Icon(Icons.my_location_outlined),
            color: Colors.black,
          ),
        ));
  }
}
