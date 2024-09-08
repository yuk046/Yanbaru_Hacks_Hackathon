import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/Pages/favorite.dart';
import 'package:munimuniohagi/Pages/post.dart';
import 'package:munimuniohagi/Pages/resultListPage.dart';

class resultPage extends HookWidget {
  const resultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = useState('sadff325hjksadf');
    final userName = useState('まっちゃん');

    final TabController _tabController = useTabController(initialLength: 2);
    final screenHeight = MediaQuery.of(context).size.height;

    final double titleHeight = screenHeight * 0.1; // 10%
    final double contentsHeight = screenHeight * 0.03; // 5%

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: titleHeight),
            Text(
              "あなたへのおすすめ",
              style: TextStyle(
                fontSize: 20.0, // フォントサイズ
                color: Colors.black, // テキストの色
              ),
            ),
            SizedBox(height: contentsHeight),
            Expanded(
              child: resultListPage(), // testPageをExpandedでラップして、残りのスペースを占める
            ),
            
          ],
        ),
      ),
    );
  }
}
