import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/Pages/akinatorResultPage.dart';
import 'package:munimuniohagi/Pages/gemini.dart';
import 'package:munimuniohagi/constant/constant.dart';

class AkinatorPage extends HookWidget {
  const AkinatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final count = useState(0); // ここでカウントの状態を管理

    void incrementCount() {
      count.value += 1;
      print(count.value);
      if (count.value == 5) {
        //5回回答すると結果画面に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AkinatorResultPage()),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(Constant.mainBackGroundColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ロゴの表示
            Container(
              width: screenSize.width * 0.8,
              child: Image.asset('assets/images/munimuni.png'),
            ),
            SizedBox(
              height: screenSize.height * 0.08,
            ),
            // 質問の表示
            Text(
              "Q. 質問を表示する？",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.05,
            ),
            // 選択肢を表示
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceButton(
                  screenSize: screenSize,
                  label: 'はい',
                  incrementCount: incrementCount,
                ),
                ChoiceButton(
                  screenSize: screenSize,
                  label: 'いいえ',
                  incrementCount: incrementCount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.screenSize,
    required this.label,
    required this.incrementCount,
  });

  final Size screenSize;
  final String label;
  final VoidCallback incrementCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // testGemini();
          // ボタンを押すと結果画面に遷移
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const AkinatorResultPage()),
          // );
          incrementCount();
        },
        child: Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.4,
          decoration: BoxDecoration(
            color: Color(0xffEFE3FF),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18, // ボタンのラベルフォントサイズ調整
              fontWeight: FontWeight.bold, // ラベルを目立たせるためのフォントウェイト
            ),
          ),
        ),
      ),
    );
  }
}
