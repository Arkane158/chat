import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String screenName = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: const Text('Home'),),);
  }
}