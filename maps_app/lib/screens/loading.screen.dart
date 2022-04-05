import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/screens/gps_access.screen.dart';
import 'package:maps_app/screens/map.screen.dart';

import '../blocs/blocs.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<GpsBloc, GpsState>(
            builder: (context, state) => state.isAllGranted
                ? const MapScreen()
                : const GpsAccessScreen()));
  }
}
