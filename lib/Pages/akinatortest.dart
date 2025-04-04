import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:munimuniohagi/Pages/chat_Contoroller.dart';
import 'package:munimuniohagi/Pages/count.dart';
import 'package:munimuniohagi/Pages/response.dart';
import 'package:munimuniohagi/Pages/result.dart';
import 'package:munimuniohagi/constant/constant.dart';

class Akinatortest extends ConsumerWidget {
  const Akinatortest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画面サイズの取得
    final screenSize = MediaQuery.of(context).size;
    // count watch
    final count = ref.watch(countNotifierProvider);
    // response watch
    final response = ref.watch(responseNotifierProvider);

    // データの更新
    void incrementCount() {
      // countNotifierを呼ぶ
      final notifier = ref.read(countNotifierProvider.notifier);
      // countデータの変更
      notifier.updateState();
      print(count);
      if (count == 3) {
        // 5回回答すると結果画面に遷移
        // 遷移のタイミングをListenerに任せるので削除
      }
    }

    // AIからの質問の取得
    Future<void> getAiQuestion(bool choice) async {
      try {
        final chatController = ChatController(ref);
        final newResponse = await chatController.sendYesNoChoice(choice);
        // ウィジェットがまだ存在するか確認
        if (context.mounted) {
          ref.read(responseNotifierProvider.notifier).state = newResponse;
        }
        print('AIの返答: $newResponse');
      } catch (e) {
        print("Error fetching AI question: $e");
      }
    }

    // responseが更新されたら画面遷移
    ref.listen<String>(responseNotifierProvider, (previousResponse, currentResponse) {
      //if (currentResponse.isNotEmpty && count == 5) {
      if (currentResponse.isNotEmpty && response.length == 20) {
        // responseが更新され、かつ3回目の回答が終わったら結果画面に遷移
        Navigator.pushReplacement(
          
          context,
          MaterialPageRoute(builder: (context) => const resultPage()),
        );
      }
    });

    return Scaffold(
      backgroundColor: Color(Constant.mainBackGroundColor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ロゴの表示
            SizedBox(
              width: screenSize.width * 0.8,
              child: Image.asset('assets/images/munimuni.png'),
            ),
            SizedBox(
              height: screenSize.height * 0.08,
            ),
            // 質問の表示
            Container(
              height: screenSize.height * 0.15,
              width: screenSize.width * 0.8,
              child: SingleChildScrollView(
                child: Text(
                  "$response",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            // 選択肢を表示
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceButton(
                  screenSize: screenSize,
                  label: 'はい',
                  choice: true,
                  incrementCount: incrementCount,
                  getAiQuestion: getAiQuestion, // コールバックを渡す
                ),
                ChoiceButton(
                  screenSize: screenSize,
                  label: 'いいえ',
                  choice: false,
                  incrementCount: incrementCount,
                  getAiQuestion: getAiQuestion, // コールバックを渡す
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceButton extends ConsumerWidget {
  const ChoiceButton({
    super.key,
    required this.screenSize,
    required this.label,
    required this.choice,
    required this.incrementCount,
    required this.getAiQuestion,
  });

  final Size screenSize;
  final String label;
  final bool choice;
  final VoidCallback incrementCount;
  final Future<void> Function(bool) getAiQuestion; // コールバックの型を指定

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countNotifierProvider);
    final chatController = ChatController(ref);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          // 1つ目の質問の表示
          if (count == 0) {
            final response = await chatController.sendPrompt();
            ref.read(responseNotifierProvider.notifier).state = response;
            print('AIの返答: $response');
            incrementCount();
          } else {
            incrementCount();
            await getAiQuestion(choice); // 2回目以降は Yes/No 質問
          }
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
