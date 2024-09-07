import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// カスタムクラス favoriteEvent
class postEvent {
  final String name;
  final String place;
  final String date; // 日付
  final String time; // 時間
  final String img;

  postEvent({
    required this.name, 
    required this.place, 
    required this.date, // 日付
    required this.time, // 時間
    required this.img
  });
}

// メインのアプリケーション
class post extends HookWidget {
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
class favoriteEventList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // フックを使ってfavoriteEventsリストを状態管理
    final favoriteEvents = useState<List<postEvent>>([
      postEvent(
        name: "ハッカソン2024", 
        place: "名護市辺野古", 
        date: "2024年5月12日", // 日付
        time: "10:00〜16:00", // 時間
        img: "https://aozorataxi.okinawa/wp-content/uploads/2023/08/okinawa_eisa.png",
      ),
      postEvent(
        name: "那覇ハーリー祭り", 
        place: "那覇市", 
        date: "2024年6月3日", // 日付
        time: "9:00〜18:00", // 時間
        img: "https://aozorataxi.okinawa/wp-content/uploads/2023/08/okinawa_eisa.png",
      ),
    ]);

    return ListView.builder(
      itemCount: favoriteEvents.value.length,
      itemBuilder: (context, index) {
        final event = favoriteEvents.value[index];

        return Container(
          margin: EdgeInsets.all(10), // 四角形の外側の余白
          decoration: BoxDecoration(
            color: Colors.white, // 背景色
            borderRadius: BorderRadius.circular(15), // 角を丸くする
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // 影の位置
              ),
            ],
            border: Border.all(color: Color(0xffE2C6FF), width: 4), // 四角形の枠線
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // 四角形内の余白
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.place,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.date, // 日付の表示
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.time, // 時間の表示
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
