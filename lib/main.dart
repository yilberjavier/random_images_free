import 'package:flutter/material.dart';
import 'package:random_images_free/pages/detalle_page.dart';
import 'package:random_images_free/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Image Free',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'detalle': (context) => DetallePage()
      },
    );
  }
}