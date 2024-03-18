import 'package:flutter/material.dart';
import 'package:is_wear/is_wear.dart';
import 'package:watch_connectivity/watch_connectivity.dart';
import 'package:wear/wear.dart';

import 'mobile_screen.dart';
import 'android_wear_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  isWear = (await IsWear().check()) ?? false;
  runApp(const MyApp());
}

late final bool isWear;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isWear
          ? AmbientMode(
              builder: (context, mode, child) => child!,
              child: AndroidWearScreen(),
            )
          : const MobileScreen(title: 'Flutter Watch Research'),
    );
  }
}

