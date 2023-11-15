import 'package:flutter/material.dart';

import '../../Constants/colors.dart';

void showCustomSnackBar(String content, BuildContext context,
    {bool isAlert = false, bool isSuccess = false}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    content: Text(
      content,
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: Colors.white),
    ),
    backgroundColor: (isAlert)
        ? (alert)
        : (isSuccess)
            ? Colors.green
            : (primaryColor),
    closeIconColor: Colors.white,
    showCloseIcon: true,
    dismissDirection: DismissDirection.down,
    duration: const Duration(seconds: 1),
  ));
}
