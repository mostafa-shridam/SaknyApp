import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';

void showSnackBar(
  BuildContext context,
  String text,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black.withOpacity(0.8),
      elevation: 10,
      showCloseIcon: true,
      closeIconColor: defaultColor,
      content: Text(
        text,
      ),
    ),
  );
}
