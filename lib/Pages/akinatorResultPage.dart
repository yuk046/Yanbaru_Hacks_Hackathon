import 'package:flutter/material.dart';
import 'package:munimuniohagi/Pages/akinatorPage.dart';
import 'package:munimuniohagi/Pages/post.dart';
import 'package:munimuniohagi/constant/constant.dart';

class AkinatorResultPage extends StatelessWidget {
  const AkinatorResultPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(Constant.mainBackGround),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            // ボタンを押すとアキネイター画面に遷移
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AkinatorPage()),
            )
          },
          icon: const Icon(Icons.arrow_back_ios_new)
        ),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: post()),
        ],),
      )
    );
  }
}