import 'package:flutter/material.dart';

infoSnackBar(BuildContext context, String message, Duration? time,
    [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: time!,
      content: Text(message),
      backgroundColor: color ?? Colors.black,
    ),
  );
}
