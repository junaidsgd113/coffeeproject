import 'dart:async';
import 'package:coffeeproject/core/riverpod/bottom_navigationbar/bottom_%20navigationbar.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const Homepage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/m.png"), fit: BoxFit.cover),
      ),
      child: Center(
          child: FlutterLogo(
        size: 300,
        textColor: Colors.black,
      )),
    );
  }
}
