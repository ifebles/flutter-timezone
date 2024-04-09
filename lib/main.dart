import 'package:flutter/material.dart';
import 'package:timezone/pages/home.dart';
import 'package:timezone/pages/loading.dart';
import 'package:timezone/pages/location.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (ctx) => const Loading(),
      '/home': (ctx) => const Home(),
      '/location': (ctx) => const Location(),
    },
  ));
}
