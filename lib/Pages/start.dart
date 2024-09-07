import 'package:flutter/material.dart';
import 'package:munimuniohagi/main.dart';
import 'package:munimuniohagi/constant/constant.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height; //端末の縦の大きさを取得
    final double deviceWidth = MediaQuery.of(context).size.width; //端末の横の大きさを取得
    return Scaffold(
      backgroundColor: Color(Constant.backGroundColor),
      body: Column(
        children: [
          SizedBox(height: deviceHeight * 0.12),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            // ロゴ画像
            child:
              Center(
                child: Container(
                  child: Image.asset('assets/images/munimuni.png'),
                  width: deviceWidth * 0.8,
                  ),
              ),
          ),
          SizedBox(height: deviceHeight * 0.18),
          Padding( // ゲストスタートボタン
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: 
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // ボタンを押すとホーム画面に遷移
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage(title: 'HomePage')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(deviceWidth * 0.7, deviceHeight * 0.08),
                    backgroundColor: Color(0xffFFE2C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ),
                  child: Text('ゲストとしてスタート'),
                ),
              )
          ),
          SizedBox(height: deviceHeight * 0.05),
          Padding( // ログインスタートボタン
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: 
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // toDo: ボタンを押すとログインページに遷移
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage(title: 'HomePage')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(deviceWidth * 0.7, deviceHeight * 0.08),
                    backgroundColor: Color(0xffFFE2C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ),
                  child: Text('ログインしてスタート'),
                ),
              )
          ),
        ],
      ),
    );
  }
}