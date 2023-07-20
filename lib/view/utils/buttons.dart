import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(this.onPressed, this.text, {this.isLoading = false});
  final Function()? onPressed;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primaryColor),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: (isLoading)
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  SecondaryButton(this.onPressed, this.text);
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
          elevation: MaterialStatePropertyAll(0),
          backgroundColor: MaterialStatePropertyAll(Color(0xFFD0D1FF)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(width: 2, color: primaryColor)))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(text, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.onPressed, required this.imgURL})
      : super(key: key);
  final Function()? onPressed;
  final String imgURL;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
            side: const MaterialStatePropertyAll(
                BorderSide(width: 1, color: CupertinoColors.systemGrey3)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            backgroundColor: const MaterialStatePropertyAll(Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset(
            imgURL,
            scale: 0.9,
          ),
        ));
  }
}
