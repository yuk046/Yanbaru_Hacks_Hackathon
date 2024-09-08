import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// カスタムクラス favoriteEvent
class favoriteEvent {
  final String name;
  final String place;
  final DateTime date; // 日付（DateTime型）
  final String img;

  favoriteEvent({
    required this.name,
    required this.place,
    required this.date, // 日付
    required this.img,
  });

  // FirestoreのドキュメントからfavoriteEventオブジェクトを生成するファクトリーメソッド
  factory favoriteEvent.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    // TimestampをDateTimeに変換
    Timestamp timestamp = data['date'] ?? Timestamp.now();
    DateTime dateTime = timestamp.toDate();

    return favoriteEvent(
      name: data['name'] ?? '',
      place: data['place'] ?? '',
      date: dateTime, // DateTime型として格納
      img: data['img'] ?? '',
    );
  }
}

// メインのアプリケーション
class post extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // favoriteEventsリストを状態管理
    final favoriteEvents = useState<List<favoriteEvent>>([]);

    // Firestoreからデータを取得してリストに追加する非同期処理
    useEffect(() {
      Future<void> fetchEvent() async {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('Event')
            .doc("MFEAxlLfAtWSCjic7mfV")
            .get();

        if (doc.exists) {
          favoriteEvents.value = [
            favoriteEvent.fromFirestore(doc),
          ];
        }
      }

      fetchEvent(); // 非同期関数を呼び出す
      return null; // クリーンアップ用関数は不要なためnull
    }, []);

    return MaterialApp(
      home: Scaffold(
        body: favoriteEventList(favoriteEvents: favoriteEvents.value),
      ),
    );
  }
}

// favoriteEventリストを表示するWidget
class favoriteEventList extends StatelessWidget {
  final List<favoriteEvent> favoriteEvents;

  favoriteEventList({required this.favoriteEvents});

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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
                        event.date.toString(), // 日付の表示
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis, // テキストが長い場合に省略表示
                      ),
                      SizedBox(height: 5),
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
