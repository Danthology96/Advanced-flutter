import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  /// android
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Espere por favor'),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Calculando ruta'),
            SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.black12,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
    return;
  }

  /// ios
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    ),
  );
}
