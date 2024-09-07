import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:munimuniohagi/Pages/favorite.dart';

class userPage extends HookWidget {
  const userPage({super.key});

  @override
  Widget build(BuildContext context) {
    final img = useState('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Stop_hand.svg/80px-Stop_hand.svg.png');
    final userID = useState('sadff325hjksadf');
    final userName = useState('まっちゃん');

    final TabController _tabController = useTabController(initialLength: 2);
    final screenHeight = MediaQuery.of(context).size.height;

    final double editHeight = screenHeight * 0.03; // 3%
    final double iconHeight = screenHeight * 0.05; // 5%
    final double contentsHeight = screenHeight * 0.05; // 5%

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: editHeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.drive_file_rename_outline,
                  size: 30,
                ),
                onPressed: () {
                  // アイコンがタップされたときの処理をここに追加
                },
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: iconHeight,
          ),
          Center(
            child: Column(
              children: [
                ClipOval(
                  child: Image.network(
                    img.value,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  userID.value,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  userName.value,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: contentsHeight),
              ],
            ),
          ),
          Container(
            height: 3,
            width: double.infinity,
            color: const Color(0xffE2C6FF),
          ),
          // ExpandedでTabBarViewの高さを確保
          Expanded(
            child: Column(
              children: [
                // タブ部分
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'お気に入り'),
                      Tab(text: '投稿'),
                    ],
                    indicatorColor: Color(0xffE2C6FF), // インジケーターの色を指定
                  ),
                ),
                // タブビュー部分
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      favorite(),
                      Center(child: Text('タブ2の内容')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
