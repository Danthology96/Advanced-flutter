import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(
    {required BuildContext context,
    required String title,
    required String subtitle}) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                MaterialButton(
                    child: const Text('OK'),
                    // elevation: 5,
                    // color: Colors.blue,
                    textColor: const Color(0xff4482EF),
                    onPressed: () => Navigator.pop(context)),
              ],
            ));
  }

  /// En caso que sea IOS
  return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                  child: const Text('OK'),
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context)),
            ],
          ));
}
