import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/custom_buttons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: height / 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Whisper Chat",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset('assets/images/astronaut_2.png'),
              Text(
                  "Create and join any number of private rooms even without disclosing your identity",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
        Lottie.asset('assets/animations/stars_animation_1.json'),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: height / 30),
            padding: EdgeInsets.fromLTRB(30, 0, 30, height / 8),
            width: width,
            child: PrimaryButton(
              () => Navigator.pushNamed(context, '/login'),
              "START",
              isLoading: isLoading,
              isContrast: true,
            ),
          ),
        ),
      ]),
    );
  }
}
