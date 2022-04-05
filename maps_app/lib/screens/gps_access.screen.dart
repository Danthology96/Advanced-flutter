import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return (!state.isGpsEnabled)
              ? const _EnableGpsMessage()
              : const _AccessButton();
        },
      )),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You must enable GPS',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'GPS access is required',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context, listen: false);
            gpsBloc.askGpsAccess();
          },
          child: const Text(
            'Request access',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
          shape: const StadiumBorder(),
          splashColor: Colors.transparent,
          elevation: 0,
        ),
      ],
    );
  }
}
