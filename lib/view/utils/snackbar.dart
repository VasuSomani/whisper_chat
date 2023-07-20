import 'package:flutter/material.dart';
import '../../Constants/colors.dart';

void showCustomSnackBar(String content, BuildContext context,
    {bool isAlert = false}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: Colors.white),
    ),
    backgroundColor: (isAlert) ? (alert) : (primaryColor),
    closeIconColor: Colors.white,
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
  ));
}
