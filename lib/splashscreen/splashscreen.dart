import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Image.asset(
              'assets/images/splashscreen.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ],
        ),
      );
}
