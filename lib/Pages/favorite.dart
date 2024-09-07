import 'package:flutter/material.dart';

// カスタムクラス favoriteEvent
class favoriteEvent {
  final String name;
  final String place;
  final String img;

  favoriteEvent({required this.name, required this.place, required this.img});
}

// メインのアプリケーション
class favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: favoriteEventList(),
      ),
    );
  }
}

// favoriteEventリストを表示するWidget
class favoriteEventList extends StatelessWidget {
  // データのリスト
  final List<favoriteEvent> favoriteEvents = [
    favoriteEvent(name: "John", place: "名護市辺野古", img: "https://www.shimacul.okinawa/wp-content/uploads/2019/03/entertain4.jpg"),
    favoriteEvent(name: "Emma", place: "那覇市", img: "https://www.shimacul.okinawa/wp-content/uploads/2019/03/entertain1.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteEvents.length,
      itemBuilder: (context, index) {
        final event = favoriteEvents[index];

        return Container(
          margin: EdgeInsets.all(10), // 四角形の外側の余白
          decoration: BoxDecoration(
            color: Colors.white, // 背景色
            borderRadius: BorderRadius.circular(10), // 角を丸くする
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // 影の位置
              ),
            ],
            border: Border.all(color: Colors.purple, width: 2), // 四角形の枠線
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // 四角形内の余白
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // 画像の角を丸くする
                  child: Image.network(
                    event.img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10), // テキストと画像の間のスペース
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      event.place,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
