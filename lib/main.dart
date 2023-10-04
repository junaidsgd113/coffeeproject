import 'package:coffeeproject/screens/splash_screen/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'firebase_options.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: Ecommerce()),
  );
}

class Ecommerce extends StatefulWidget {
  const Ecommerce({super.key});

  @override
  State<Ecommerce> createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  @override
  Widget build(BuildContext context) {
    {
      return const MaterialApp(
        localizationsDelegates:
            MonthYearPickerLocalizations.localizationsDelegates,
        supportedLocales: MonthYearPickerLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }
  }
}
