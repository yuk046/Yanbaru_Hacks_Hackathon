import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StartPage extends HookWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("こんにちは")
        ],
      ),
      backgroundColor: Color(0xffE2C6FF),
    );
  }
}